


#import <Foundation/Foundation.h>
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSSubmissionInterface <NSObject>

@required
-(NSURL*__nullable)destinationURL;
-(RDSSubmissionContentType)submissionContentType;
@optional
-(NSDictionary*__nullable)parameters;
-(NSString*__nullable)HTTPMethod;


@end
NS_ASSUME_NONNULL_END
