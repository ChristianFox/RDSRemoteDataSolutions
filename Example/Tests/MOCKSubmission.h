


#import <Foundation/Foundation.h>
#import <RDSRemoteDataSolutions/RDSSubmissionInterface.h>

NS_ASSUME_NONNULL_BEGIN
@interface MOCKSubmission : NSObject <RDSSubmissionInterface>

@property (strong,atomic,nullable) NSURL *destinationURL;

@end
NS_ASSUME_NONNULL_END
