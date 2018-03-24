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
#import "RDSDefinitions.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RDSSubmissionInterface <NSObject,NSCoding>

@required
/**
 * @brief The URL the data should be sent to
 * @return An NSURL object.
 * @since 0.2.0
 **/
-(NSURL*__nullable)destinationURL;

/**
 * @brief The type of content that will be sent and what is expected by the backend API - as in the HTTP header Content-Type.
 * @return A RDSSubmissionContentType Enum
 * @since 0.3.0
 **/
-(RDSSubmissionContentType)submissionContentType;


@optional
/**
 * @brief The parameters to send to the URL
 * @return An NSDictionary containing the keys and values expected by the backend API
 * @since 0.3.0
 **/
-(NSDictionary*__nullable)parameters;

/**
 * @brief The HTTP Method to use. POST, GET, PUT etc
 * @return An NSString with the HTTP method.
 * @since 0.3.0
 **/
-(NSString*__nullable)HTTPMethod;


/**
 * @brief Whether the submission should be scheduled to be resubmitted at a later date if it fails. If YES then it will be resubmitted until it succeeds.
 * @return A boolean value indicating whether this object should be resubmitted or not.
 * @since 0.6.0
 **/
-(BOOL)shouldScheduleForResubmissionOnFailure;

@end
NS_ASSUME_NONNULL_END
