

#import "RDSResubmissionOperation.h"
// Components
#import "RDSSubmitter.h"
// Constants
#import "RDSConstants.h"

@interface RDSResubmissionOperation ()

@property (strong,atomic) RDSSubmitter *submitter;
@property (strong,atomic) NSMutableArray<id<RDSSubmissionInterface>> *submissions;
@property (atomic,readwrite) NSUInteger submissionsCount;
@property (atomic,readwrite) NSUInteger submissionSuccesses;
@property (atomic,readwrite) NSUInteger submissionFailures;

@end

@implementation RDSResubmissionOperation


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)resubmissionOperationWithSubmissions:(NSMutableArray<id<RDSSubmissionInterface>> *)submissions
                                          submitter:(RDSSubmitter *)submitter{
    
    if (submissions.count == 0 || submitter == nil) {
        return nil;
    }
    RDSResubmissionOperation *operation = [[self alloc]init];
    operation.submitter = submitter;
    operation.submissions = submissions;
    operation.submissionsCount = operation.submissions.count;
    operation.submissionSuccesses = 0;
    operation.submissionFailures = 0;
    return operation;
}




-(void)main{
    
    @autoreleasepool {
        
        if (self.isCancelled) {
            return;
        }
        
        
        // If the array is empty then notify that we have completed
        if (self.submissions.count == 0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kRDSResubmissionProcessCompleteNOTIFICATION
                                                               object:nil
                                                             userInfo:@{kRDSResubmissionResultKEY:@(YES)}];
            return;
        }
        
        
        // ## Attempt to submit each submission ##
        // For now just try them all... if it becomes a bottle neck then change to stop after the first failure
        // My thinking is that just because 1 or more fail doesn't mean they all will - connection could be poor but present
        // Also if there is no connection, failing to send n is probably not going to use much resources than failing to send 1, unless n is some huge number
        
        __block NSUInteger index = 0;
        //  NSLog(@"## Attempt to submit %ld submissions from store",(unsigned long)submissions.count);
        for (id<RDSSubmissionInterface> aSubmission in self.submissions) {
            
            //  NSLog(@"# Attempt to submit submission: %@",aSubmission);
            
            [self.submitter submitSubmission:aSubmission
                              withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
             {
                 // ## Determine if success or failure  ##
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                 if (httpResponse.statusCode == 200) {

                     self.submissionSuccesses++;
                     [self.delegate resubmissionOperation:self
                          didSuccessfullySubmitSubmission:aSubmission
                                                 withData:data
                                                 response:response];
                 }else{
                     self.submissionFailures++;
                     if ([self.delegate respondsToSelector:@selector(resubmissionOperation:didFailToSubmitSubmission:withError:)]) {
                         [self.delegate resubmissionOperation:self didFailToSubmitSubmission:aSubmission withError:error];
                     }
                 }
                 
                 // ## Completion check ##
                 // Have we tried all submissions?
                 //  NSLog(@"index = %lu, originalCount = %lu, currentCount = %lu",(unsigned long)index,(unsigned long)originalCount,(unsigned long)self.submissionsStorage.count);
                 if (++index >= self.submissionsCount) {
                     // Then we are done here.
                     // Post Completion Notification
                     BOOL clearedAllSubmissions = NO; // if the are any left then we were not 100% successful
                     clearedAllSubmissions = (self.submissionSuccesses == self.submissionsCount) ? YES : NO;
                     [[NSNotificationCenter defaultCenter]postNotificationName:kRDSResubmissionProcessCompleteNOTIFICATION
                                                                        object:nil
                                                                      userInfo:@{kRDSResubmissionResultKEY:@(clearedAllSubmissions)}];
                     [self.delegate resubmissionOperationDidFinish:self];
                     return;
                 }
             }];
        }
    }
}









@end
