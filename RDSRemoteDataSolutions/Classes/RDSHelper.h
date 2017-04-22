

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
 * @brief Use class method instead
 * @param
 * @return
 * @since 0.3.0
 **/
-(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params DEPRECATED_ATTRIBUTE;

/**
 * @brief
 * @param
 * @return
 * @since 0.8.0
 **/
+(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params;


/**
 * @brief
 * @param
 * @return
 * @since 0.8.0
 **/
+(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params withOrderedKeys:(NSArray*)orderedKeys;

/**
 * @brief
 * @param
 * @return
 * @since 0.8.0
 **/
+(NSString*)urlEncodedStringFromKey:(NSString*)key value:(id)value;

/**
 * @brief
 * @param
 * @return
 * @since 0.8.0
 **/
+(NSDictionary*)parseQueryString:(NSString*)query;

@end
NS_ASSUME_NONNULL_END
