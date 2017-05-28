/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

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
 * @param params An NSDictionary of parameters to encode into a string
 * @return An NSString with keys and values encoded eg. key1=value1&key2=value2
 * @since 0.3.0
 **/
-(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params DEPRECATED_ATTRIBUTE;

/**
 * @brief Takes a dictionay of keys and values and parses into a WWW Form URL Encoded String
 * @param params An NSDictionary of parameters to encode into a string
 * @return An NSString with keys and values encoded eg. key1=value1&key2=value2
 * @since 0.8.0
 **/
+(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params;


/**
 * @brief Takes a dictionay of keys and values and parses into a WWW Form URL Encoded String, sorted into the order defined in orderedKeys paramters
 * @param params An NSDictionary of parameters to encode into a string
 * @param orderedKeys An NSArray of keys with which to order the parameters when encoding into a string. Every key in the params should be included. Counts should be equal.
 * @return An NSString with keys and values encoded eg. key1=value1&key2=value2
 * @since 0.8.0
 **/
+(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params withOrderedKeys:(NSArray*)orderedKeys;

/**
 * @brief Returns a string in the format key=value
 * @param key the key
 * @param value the value
 * @return An NSString with keys and values encoded eg. key1=value1&key2=value2
 * @since 0.8.0
 **/
+(NSString*)urlEncodedStringFromKey:(NSString*)key value:(id)value;

/**
 * @brief Takes the query string part of a URL in a WWWFormURLEncodedString format and breaks it down into keys and values discarding any '=' signs
 * @param query the query part of a URL
 * @return An NSDicationary including all keys and values included in query
 * @since 0.8.0
 **/
+(NSDictionary*)parseQueryString:(NSString*)query;

@end
NS_ASSUME_NONNULL_END
