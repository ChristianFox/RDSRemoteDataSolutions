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
#import "RDSSubmissionInterface.h"

NS_ASSUME_NONNULL_BEGIN
@interface RDSValidator : NSObject

//--------------------------------------------------------
#pragma mark - Initilise
//--------------------------------------------------------
+(instancetype)validator;

//--------------------------------------------------------
#pragma mark - Validate
//--------------------------------------------------------
/**
 * @brief Validate the Submission
 * @param submission the object to validate
 * @param error A pointer to an NSError object. Object will be created upon return if validation failed
 * @return YES if valid, NO if not
 * @since 0.5.0
 **/
-(BOOL)validateSubmission:(id<RDSSubmissionInterface>)submission
                withError:(NSError* _Nullable*)error;

/**
 * @brief Validate the URL
 * @param url the object to validate
 * @param error A pointer to an NSError object. Object will be created upon return if validation failed
 * @return YES if valid, NO if not
 * @since 0.5.0
 **/
-(BOOL)validateDestinationURL:(NSURL*)url
                    withError:(NSError* _Nullable*)error;

/**
 * @brief Validate the Parameters
 * @param parameters the object to validate
 * @param error A pointer to an NSError object. Object will be created upon return if validation failed
 * @return YES if valid, NO if not
 * @since 0.5.0
 **/
-(BOOL)validateParameters:(NSDictionary*)parameters
                withError:(NSError* _Nullable*)error;

/**
 * @brief Validate the JSONData
 * @param jsonData the object to validate
 * @param error A pointer to an NSError object. Object will be created upon return if validation failed
 * @return YES if valid, NO if not
 * @since 0.5.0
 **/
-(BOOL)validateJSONData:(NSData*)jsonData
              withError:(NSError* _Nullable*)error;

/**
 * @brief Validate the encoded String
 * @param encodedString the object to validate
 * @param error A pointer to an NSError object. Object will be created upon return if validation failed
 * @return YES if valid, NO if not
 * @since 0.5.0
 **/
-(BOOL)validateWWWURLEncodedString:(NSString*)encodedString
                         withError:(NSError* _Nullable*)error;



@end
NS_ASSUME_NONNULL_END

