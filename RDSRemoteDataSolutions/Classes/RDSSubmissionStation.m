

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
// Cocoa Categories
#import "NSError+RDSErrors.h"
// Constants
#import "RDSConstants.h"

NSString *const kPendingSubmissionsArchiveFileName = @"PendingSubmissions";

@interface RDSSubmissionStation () <RDSResubmissionOperationDelegate>

// Store
@property (strong,nonatomic) NSMutableArray *pendingSubmissions;
// Components
@property (strong,nonatomic) RDSSubmitter *submitter;
@property (strong,nonatomic) RDSScheduler *scheduler;

@property (strong,nonatomic) NSOperationQueue *operationQueue;

@end

@implementation RDSSubmissionStation


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
        if (submission == nil) {
            error = [NSError rds_submissionIsNilError];
        }else if ([submission destinationURL] == nil){
            error = [NSError rds_submissionURLIsNilError];
        }else if ([submission submissionContentType] == RDSSubmissionContentTypeUndefined){
            error = [NSError rds_SubmissionContentTypeIsUndefined];
        }
        
        if (error != nil) {
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
                                  
                                  [welf storeAndScheduleSubmission:submission];
                                  
                              }
                              
                              completionBlock(data,response,error);
                              
                          }];
        
    }];
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
-(void)resubmissionOperation:(RDSResubmissionOperation *)operation didSuccessfullySubmitSubmission:(id<RDSSubmissionInterface>)submission{
    
    [self.pendingSubmissions removeObject:submission];
}



//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Storing Submissions
//--------------------------------------------------------
-(void)storeAndScheduleSubmission:(id<RDSSubmissionInterface>)submission{
    
    if (![self.pendingSubmissions containsObject:submission]) {
        
        [self.pendingSubmissions addObject:submission];
        [self archivePendingSubmissionsWithError:nil];
        
        NSNotification *note = [NSNotification notificationWithName:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                                             object:nil];
        [[NSNotificationCenter defaultCenter]postNotification:note];
    }
    
}

-(BOOL)archivePendingSubmissionsWithError:(NSError*__autoreleasing __nullable*)error{
    
    BOOL success = NO;
    success = [NSKeyedArchiver kfx_archiveRootObject:self.pendingSubmissions
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
    [RDSResubmissionOperation resubmissionOperationWithSubmissions:[self.pendingSubmissions copy]
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



//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
-(NSMutableArray *)pendingSubmissions{
    if (!_pendingSubmissions) {
        
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
            _pendingSubmissions = [NSMutableArray arrayWithCapacity:1];
        }else{
            _pendingSubmissions = [submissions mutableCopy];
        }
    }
    return _pendingSubmissions;
}


-(NSOperationQueue *)operationQueue{
    if (!_operationQueue){
        _operationQueue = [[NSOperationQueue alloc]init];
    }
    return _operationQueue;
}





@end
