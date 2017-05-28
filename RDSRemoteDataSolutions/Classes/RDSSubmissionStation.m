/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

#import "RDSSubmissionStation.h"
// Pods
#import <KFXAdditions/NSFileManager+KFXDirectoryLocations.h>
#import <KFXAdditions/NSKeyedArchiver+KFXAdditions.h>
#import <KFXAdditions/NSKeyedUnarchiver+KFXAdditions.h>
// Components
#import "RDSSubmitter.h"
#import "RDSScheduler.h"
#import "RDSNetworkConnector.h"
#import "RDSResubmissionOperation.h"
#import "RDSValidator.h"
// Cocoa Categories
#import "NSError+RDSErrors.h"

// Constants
#import "RDSConstants.h"

NSString *const kPendingSubmissionsArchiveFileName = @"PendingSubmissions";

@interface RDSSubmissionStation () <RDSResubmissionOperationDelegate>

// Store
@property (strong,nonatomic) NSMutableArray *pendingSubmissionsMutable;
// Components
@property (strong,nonatomic) RDSSubmitter *submitter;
@property (strong,nonatomic) RDSScheduler *scheduler;

@property (strong,nonatomic) NSOperationQueue *operationQueue;

@end

@implementation RDSSubmissionStation

@synthesize validator = _validator;
@synthesize loggingDelegate = _loggingDelegate;


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)defaultSubmissionStation{
    
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    RDSSubmissionStation *station = [self submissionStationWithNetworkConnector:connector];

    return station;
}

+(instancetype)submissionStationWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector{
    
    if (networkConnector == nil) {
        return nil;
    }
    RDSSubmissionStation *station = [[self alloc]init];
    // register for notifications straight away just incase scheduler fires off a notification during initilisation
    [station registerForNotifications];
    station.submitter = [RDSSubmitter submitterWithNetworkConnector:networkConnector];
    station.scheduler = [RDSScheduler defaultScheduler];
    if (station.pendingSubmissionsMutable.count >= 1) {
        [station postSubmissionStoredForResubmissionNotification];
    }
    return station;
}


//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    __weak typeof(self) welf = self;
    [self.operationQueue addOperationWithBlock:^{
       
        // ## Defensive
        NSError *error;
        if (![self.validator validateSubmission:submission withError:&error]) {
            completionBlock(nil,nil,error);
            return;
        }else if ([submission submissionContentType] == RDSSubmissionContentTypeUndefined){
            error = [NSError rds_SubmissionContentTypeIsUndefined];
            completionBlock(nil,nil,error);
            return;
        }
        
        // ## Passed Defenses
        [welf.submitter submitSubmission:submission
                          withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              
                              
                              /*
                               If it failed then store and schedule the submission for resubmission when the time is right. 
                               */
                              
                              if ([(NSHTTPURLResponse*)response statusCode] != 200 || error != nil) {
                                  
                                  if ([submission shouldScheduleForResubmissionOnFailure]) {
                                         [welf storeAndScheduleSubmission:submission];
                                  }else{
                                      // If this submission is a resubmission it will already be in the pendingSubmissionsMutable array but the bool -shouldSchedule may have changed, so in case that is the case run the submission through the -removePending method.
                                      [welf removePendingSubmission:submission];
                                  }
                              }
                              
                              completionBlock(data,response,error);
                              
                          }];
        
    }];
}


//--------------------------------------------------------
#pragma mark - Resubmission Scheduling
//--------------------------------------------------------
-(NSArray*)pendingSubmissions{
    return [self.pendingSubmissionsMutable copy];
}

-(void)removePendingSubmission:(id<RDSSubmissionInterface>)submission{
    if ([self.pendingSubmissionsMutable containsObject:submission]) {
        [self.pendingSubmissionsMutable removeObject:submission];
    }
}



//--------------------------------------------------------
#pragma mark - Accessors
//--------------------------------------------------------
-(void)setLoggingDelegate:(id<RDSLoggingDelegate>)loggingDelegate{
    @synchronized (_loggingDelegate) {
        if (loggingDelegate != _loggingDelegate) {
            _loggingDelegate = loggingDelegate;
            self.submitter.loggingDelegate = loggingDelegate;
            self.scheduler.loggingDelegate = loggingDelegate;
        }
    }
}

-(id<RDSLoggingDelegate>)loggingDelegate{
    id<RDSLoggingDelegate> delegate;
    @synchronized (_loggingDelegate) {
        delegate = _loggingDelegate;
    }
    return delegate;
    
}

-(void)setValidator:(RDSValidator *)validator{
    @synchronized (_validator) {
        if (validator != _validator) {
            _validator = validator;
            self.submitter.validator = validator;
        }
    }
}

-(RDSValidator *)validator{
    RDSValidator *validator;
    @synchronized (_validator) {
        if (!_validator) {
            _validator = [RDSValidator validator];
        }
        validator = _validator;
    }
    return validator;
}


//======================================================
#pragma mark - ** Inherited Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - NSObject
//--------------------------------------------------------
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - RDSResubmissionOperationDelegate
//--------------------------------------------------------
-(void)resubmissionOperation:(RDSResubmissionOperation *)operation didSuccessfullySubmitSubmission:(id<RDSSubmissionInterface>)submission withData:(nonnull NSData *)data response:(nonnull NSURLResponse *)response{
    
    [self.pendingSubmissionsMutable removeObject:submission];
    
    if ([self.delegate respondsToSelector:@selector(submissionStation:didSuccessfullySubmitSubmission:withData:response:)]) {
        [self.delegate submissionStation:self didSuccessfullySubmitSubmission:submission withData:data response:response];
    }
}

-(void)resubmissionOperation:(RDSResubmissionOperation *)operation didFailToSubmitSubmission:(id<RDSSubmissionInterface>)submission withError:(nonnull NSError *)error{
    
    if ([self.delegate respondsToSelector:@selector(submissionStation:didFailToSubmitSubmission:withError:)]) {
        [self.delegate submissionStation:self didFailToSubmitSubmission:submission withError:error];
    }
}

-(void)resubmissionOperationDidFinish:(RDSResubmissionOperation *)operation{
    
    if ([self.delegate respondsToSelector:@selector(submissionStation:didCompleteResubmissionProcessWithSubmissionSuccesses:submissionFailures:)]){
        [self.delegate submissionStation:self didCompleteResubmissionProcessWithSubmissionSuccesses:operation.submissionSuccesses submissionFailures:operation.submissionFailures];
    }
    
}

//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Storing Submissions
//--------------------------------------------------------
-(void)storeAndScheduleSubmission:(id<RDSSubmissionInterface>)submission{
    
    if (![self.pendingSubmissionsMutable containsObject:submission]) {
        
        [self.pendingSubmissionsMutable addObject:submission];
        [self archivePendingSubmissionsWithError:nil];

        [self postSubmissionStoredForResubmissionNotification];
        if ([self.loggingDelegate respondsToSelector:@selector(logInfo:)]) {
            NSString *message = [NSString stringWithFormat:@"RDSSubmissionStation has %lu pending submissions.",(unsigned long)_pendingSubmissionsMutable.count];
            [self.loggingDelegate logInfo:message];
        }

    }
    
}

-(BOOL)archivePendingSubmissionsWithError:(NSError*__autoreleasing __nullable*)error{
    
    BOOL success = NO;
    success = [NSKeyedArchiver kfx_archiveRootObject:self.pendingSubmissionsMutable
                                     toDirectoryPath:[self pendingSubmissionsArchiveDirectoryPathWithError:error]
                                        withFileName:kPendingSubmissionsArchiveFileName
                                               error:error];
    return success;
    
}

-(NSString*)pendingSubmissionsArchiveDirectoryPathWithError:(NSError*__autoreleasing __nullable*)error{
    
    NSFileManager *fileMan = [NSFileManager defaultManager];
    NSString *archiveDir = [fileMan kfx_findOrCreateDirectory:NSApplicationSupportDirectory
                                                     inDomain:NSUserDomainMask
                                          appendPathComponent:@"RDSArchives"
                                                        error:error];
    return archiveDir;
}


//--------------------------------------------------------
#pragma mark - Resubmitting Submissions
//--------------------------------------------------------
-(void)startResubmissionOperation{
    
    
    RDSResubmissionOperation *operation =
    [RDSResubmissionOperation resubmissionOperationWithSubmissions:[self.pendingSubmissionsMutable copy]
                                                         submitter:self.submitter];
    operation.delegate = self;
    [self.operationQueue addOperation:operation];

}


//--------------------------------------------------------
#pragma mark - Notifications
//--------------------------------------------------------
-(void)registerForNotifications{
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(startResubmissionOperation)
                                                name:kRDSShouldAttemptResubmissionNOTIFICATION
                                              object:nil];
}

-(void)postSubmissionStoredForResubmissionNotification{
    
    NSNotification *note = [NSNotification notificationWithName:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                                         object:nil
                                                       userInfo:@{kRDSPendingSubmissionsCountKEY:@(self.pendingSubmissionsMutable.count)}];
    [[NSNotificationCenter defaultCenter]postNotification:note];

}

//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
-(NSMutableArray *)pendingSubmissionsMutable{
    if (!_pendingSubmissionsMutable) {
        
        NSError *error;
        NSString *dirPath = [self pendingSubmissionsArchiveDirectoryPathWithError:&error];
        if (dirPath == nil) {
            NSLog(@"<ERROR> DirectoryPath for RDSRemoteDataSolutions pending submissions archive is nil: %@",error.localizedDescription);
        }
        NSArray *submissions = [NSKeyedUnarchiver kfx_unarchiveObjectFromDirectoryPath:dirPath
                                                                          withFileName:kPendingSubmissionsArchiveFileName
                                                                                 error:&error];
        if (submissions == nil) {
            if (error != nil) {
                NSLog(@"<ERROR> RDSRemoteDataSolutions pending submissions archive is nil: %@",error.localizedDescription);
            }
            _pendingSubmissionsMutable = [NSMutableArray arrayWithCapacity:1];
        }else{
            _pendingSubmissionsMutable = [submissions mutableCopy];
        }
    }
    return _pendingSubmissionsMutable;
}


-(NSOperationQueue *)operationQueue{
    if (!_operationQueue){
        _operationQueue = [[NSOperationQueue alloc]init];
    }
    return _operationQueue;
}





@end
