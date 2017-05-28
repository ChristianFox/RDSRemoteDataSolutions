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
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSNetworkConnectorInterface <NSObject>

/**
 * @brief Performs a data task with the given URL. Sending data to that URL.
 * @param url the url to send data to
 * @param completionBlock A block called on completion
 * @since 0.2.0
 **/
-(void)dataTaskWithURL:(NSURL *)url
            completion:(RDSNetworkResponseCompletionBlock)completionBlock;

/**
 * @brief Performs a data task with the given URL. Sending data to that URL.
 * @param url the url to send data to
 * @param additionalHeaderFields Specifiy any additional Header Fields by passing a dictionary
 * @param httpMethod The HTTPMethod to use (GET, POST, PUT, DELETE)
 * @param completionBlock A block called on completion
 * @since 0.8.0
 **/
-(void)dataTaskWithURL:(NSURL *)url
additionalHeaderFields:(NSDictionary<NSString*,NSString*>*)additionalHeaderFields
            HTTPMethod:(NSString*)httpMethod
            completion:(RDSNetworkResponseCompletionBlock)completionBlock;


/**
 * @brief Performs a data task with the given URL. Sending the jsonData to that URL.
 * @param jsonData A JSON object serialised into an NSData object
 * @param url the url to send data to
 * @param httpMethod The HTTPMethod to use (GET, POST, PUT, DELETE)
 * @param completionBlock A block called on completion
 * @since 0.2.0
 **/
-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock;

/**
 * @brief Performs a data task with the given URL. Sending the jsonData to that URL.
 * @param jsonData A JSON object serialised into an NSData object
 * @param url the url to send data to
 * @param additionalHeaderFields Specifiy any additional Header Fields by passing a dictionary
 * @param httpMethod The HTTPMethod to use (GET, POST, PUT, DELETE)
 * @param completionBlock A block called on completion
 * @since 0.8.0
 **/
-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
     additionalHeaderFields:(nullable NSDictionary<NSString*,NSString*>*)additionalHeaderFields
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock;


/**
 * @brief Performs a data task with the given URL. Appending the urlEncodedString onto the URL
 * @param url the url to send data to
 * @param httpMethod The HTTPMethod to use (GET, POST, PUT, DELETE)
 * @param completionBlock A block called on completion
 * @since 0.2.0
 **/
-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock;

/**
 * @brief Performs a data task with the given URL. Appending the urlEncodedString onto the URL
 * @param url the url to send data to
 * @param additionalHeaderFields Specifiy any additional Header Fields by passing a dictionary
 * @param httpMethod The HTTPMethod to use (GET, POST, PUT, DELETE)
 * @param completionBlock A block called on completion
 * @since 0.8.0
 **/
-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
             additionalHeaderFields:(nullable NSDictionary<NSString*,NSString*>*)additionalHeaderFields
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
