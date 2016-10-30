

#import <Foundation/Foundation.h>
// Protocols
#import "RDSNetworkConnectorInterface.h"
#import "RDSSubmissionInterface.h"



NS_ASSUME_NONNULL_BEGIN
@interface RDSSubmissionStation : NSObject

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;
/**
 * @brief
 * @since 0.4.0
 **/
+(instancetype)defaultSubmissionStation;
/**
 * @brief
 * @param
 * @since 0.4.0
 **/
+(instancetype)submissionStationWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector;


//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
/**
 * @brief
 * @param
 * @param
 * @since 0.4.0
 **/
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
