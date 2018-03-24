/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/


#import <Foundation/Foundation.h>
// Protocols
#import "RDSNetworkConnectorInterface.h"
#import "RDSSubmissionInterface.h"
#import "RDSLoggingDelegate.h"
// Constants
#import "RDSDefinitions.h"
// Other
@class RDSValidator;

NS_ASSUME_NONNULL_BEGIN
@interface RDSSubmitter : NSObject

@property (strong,nonatomic,readonly) id<RDSNetworkConnectorInterface> networkConnector;
@property (weak, atomic) id<RDSLoggingDelegate> loggingDelegate;
@property (strong, atomic) RDSValidator *validator;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;
/**
 * @brief Convinience initiliser
 * @return An instance of RDSSubmitter with default network connector
 * @since 0.2.0
 **/
+(instancetype)defaultSubmitter;
/**
 * @brief Convinience initiliser
 * @param networkConnector An object conforming to RDSNetworkConnectorInterface to be used instead of the default RDSNetworkConnectorInterface object
 * @return An instance of RDSSubmitter using the specified networkConnector
 * @since 0.2.0
 **/
+(instancetype)submitterWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector;

//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
/**
 * @brief Submit a submission (object conforming to RDSSubmissionInterface) to its designated url
 * @param submission An object conforming to RDSSubmissionInterface.
 * @param completionBlock A block called on completion
 * @since 0.2.0
 **/
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
