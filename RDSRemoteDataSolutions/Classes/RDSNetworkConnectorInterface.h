

#import <Foundation/Foundation.h>
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSNetworkConnectorInterface <NSObject>

-(void)dataTaskWithURL:(NSURL *)url
            completion:(RDSNetworkResponseCompletionBlock)completionBlock;

-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock;

-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
