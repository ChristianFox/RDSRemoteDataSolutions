


#import <Foundation/Foundation.h>
#import "RDSSubmissionInterface.h"
@class RDSSubmitter;
@class RDSResubmissionOperation;

NS_ASSUME_NONNULL_BEGIN
@protocol RDSResubmissionOperationDelegate <NSObject>

-(void)resubmissionOperation:(RDSResubmissionOperation*)operation didSuccessfullySubmitSubmission:(id<RDSSubmissionInterface>)submission withData:(NSData*)data response:(NSURLResponse*)response;
@optional
-(void)resubmissionOperation:(RDSResubmissionOperation*)operation didFailToSubmitSubmission:(id<RDSSubmissionInterface>)submission withError:(NSError*)error;
-(void)resubmissionOperationDidFinish:(RDSResubmissionOperation*)operation;
@end


@interface RDSResubmissionOperation : NSOperation

@property (weak, nonatomic) id<RDSResubmissionOperationDelegate> delegate;
/// How many Submissions needed to be submitted at the start of the operation
@property (atomic,readonly) NSUInteger submissionsCount;
/// How many Submissions were successfully submitted
@property (atomic,readonly) NSUInteger submissionSuccesses;
/// How many Submissions were not successfully submitted
@property (atomic,readonly) NSUInteger submissionFailures;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;
/**
 * @brief Convinience initiliser
 * @param
 * @param
 * @return
 * @since 0.4.0
 **/
+(instancetype)resubmissionOperationWithSubmissions:(NSArray<id<RDSSubmissionInterface>>*)submissions
                                          submitter:(RDSSubmitter*)submitter;

@end
NS_ASSUME_NONNULL_END
