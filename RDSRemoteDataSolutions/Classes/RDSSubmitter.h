


#import <Foundation/Foundation.h>
// Protocols
#import "RDSNetworkConnectorInterface.h"
#import "RDSSubmissionInterface.h"
// Constants
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@interface RDSSubmitter : NSObject

@property (strong,nonatomic,readonly) id<RDSNetworkConnectorInterface> networkConnector;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;
/**
 * @brief
 * @param
 * @param
 * @since 0.2.0
 **/
+(instancetype)defaultSubmitter;
/**
 * @brief
 * @param
 * @param
 * @since 0.2.0
 **/
+(instancetype)submitterWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector;

//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
/**
 * @brief
 * @param
 * @param
 * @since 0.2.0
 **/
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
