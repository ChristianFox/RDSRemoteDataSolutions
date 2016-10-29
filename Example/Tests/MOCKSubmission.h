


#import <Foundation/Foundation.h>
#import <RDSRemoteDataSolutions/RDSSubmissionInterface.h>

NS_ASSUME_NONNULL_BEGIN
@interface MOCKSubmission : NSObject <RDSSubmissionInterface>

@property (strong,atomic,nullable) NSURL *destinationURL;
@property (strong,atomic,nullable) NSDictionary *parameters;
@property (atomic) RDSSubmissionContentType submissionContentType;
@property (strong,atomic,nullable) NSString *HTTPMethod;

@end
NS_ASSUME_NONNULL_END
