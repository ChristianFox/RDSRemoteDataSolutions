

#import <Foundation/Foundation.h>
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSNetworkConnectorInterface <NSObject>

/**
 * @brief
 * @param
 * @param
 * @since 0.2.0
 **/
-(void)dataTaskWithURL:(NSURL *)url
            completion:(RDSNetworkResponseCompletionBlock)completionBlock;


/**
 * @brief
 * @param
 * @param
 * @param
 * @param
 * @since 0.2.0
 **/
-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock;

/**
 * @brief
 * @param
 * @param
 * @param
 * @param
 * @since 0.2.0
 **/
-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
