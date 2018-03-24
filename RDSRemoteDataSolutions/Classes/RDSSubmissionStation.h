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
//
@class RDSValidator;

NS_ASSUME_NONNULL_BEGIN
@class RDSSubmissionStation;
@protocol RDSSubmissionStationDelegate <NSObject>

@optional
-(void)submissionStation:(RDSSubmissionStation*)submissionStation
didCompleteResubmissionProcessWithSubmissionSuccesses:(NSUInteger)submissionSuccesses
      submissionFailures:(NSUInteger)submissionFailures;
-(void)submissionStation:(RDSSubmissionStation*)submissionStation didSuccessfullySubmitSubmission:(id<RDSSubmissionInterface>)submission
withData:(NSData*)data response:(NSURLResponse*)response;
-(void)submissionStation:(RDSSubmissionStation*)submissionStation didFailToSubmitSubmission:(id<RDSSubmissionInterface>)submission withError:(NSError*)error;

@end


@interface RDSSubmissionStation : NSObject

@property (weak, atomic) id<RDSSubmissionStationDelegate> delegate;
@property (weak, atomic) id<RDSLoggingDelegate> loggingDelegate;
@property (strong, atomic) RDSValidator *validator;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;
/**
 * @brief Convinience initiliser
 * @return An instance of RDSSubmissionStation with default network connector
 * @since 0.4.0
 **/
+(instancetype)defaultSubmissionStation;
/**
 * @brief Convinience initiliser
 * @param networkConnector An object conforming to RDSNetworkConnectorInterface to be used instead of the default RDSNetworkConnectorInterface object
 * @return An instance of RDSSubmissionStation using the specified networkConnector
 * @since 0.4.0
 **/
+(instancetype)submissionStationWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector;


//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
/**
 * @brief Submit a submission (object conforming to RDSSubmissionInterface) to its designated url
 * @param submission An object conforming to RDSSubmissionInterface.
 * @param completionBlock A block called on completion
 * @since 0.4.0
 **/
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock;


//--------------------------------------------------------
#pragma mark - Resubmission Scheduling
//--------------------------------------------------------
-(NSArray*)pendingSubmissions;
-(void)removePendingSubmission:(id<RDSSubmissionInterface>)submission;



@end
NS_ASSUME_NONNULL_END
