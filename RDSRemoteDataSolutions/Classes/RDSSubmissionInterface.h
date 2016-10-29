


#import <Foundation/Foundation.h>
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSSubmissionInterface <NSObject>

@required
-(NSURL*__nullable)destinationURL;
-(RDSSubmissionContentType)submissionContentType;
@optional
-(NSDictionary*)parameters;
-(NSString*)HTTPMethod;


@end
NS_ASSUME_NONNULL_END
