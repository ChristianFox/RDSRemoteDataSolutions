

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface RDSHelper : NSObject

/**
 * @brief Convinience initiliser
 * @return An instance of RDSHelper
 * @since 0.3.0
 **/
+(instancetype)helper;

/**
 * @brief
 * @param
 * @return
 * @since 0.3.0
 **/
-(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params;

@end
NS_ASSUME_NONNULL_END
