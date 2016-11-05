

@import Foundation;
#import <RDSRemoteDataSolutions/RDSSubmissionInterface.h>

NS_ASSUME_NONNULL_BEGIN
@interface RDSSubmission : NSObject <RDSSubmissionInterface>

@property (strong,atomic,nullable) NSURL *destinationURL;
@property (strong,atomic,nullable) NSDictionary *parameters;
@property (atomic) RDSSubmissionContentType submissionContentType;
@property (strong,atomic,nullable) NSString *HTTPMethod;
@property (nonatomic) BOOL shouldScheduleForResubmissionOnFailure;

+(instancetype)submission;

@end
NS_ASSUME_NONNULL_END
