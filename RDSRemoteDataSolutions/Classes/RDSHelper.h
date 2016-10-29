

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface RDSHelper : NSObject

+(instancetype)helper;

-(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params;

@end
NS_ASSUME_NONNULL_END
