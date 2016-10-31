

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
 * @brief
 * @param
 * @param
 * @return
 * @since 0.5.0
 **/
-(BOOL)validateSubmission:(id<RDSSubmissionInterface>)submission
                withError:(NSError* _Nullable*)error;

/**
 * @brief
 * @param
 * @param
 * @return
 * @since 0.5.0
 **/
-(BOOL)validateDestinationURL:(NSURL*)url
                    withError:(NSError* _Nullable*)error;

/**
 * @brief
 * @param
 * @param
 * @return
 * @since 0.5.0
 **/
-(BOOL)validateParameters:(NSDictionary*)parameters
                withError:(NSError* _Nullable*)error;

/**
 * @brief
 * @param
 * @param
 * @return
 * @since 0.5.0
 **/
-(BOOL)validateJSONData:(NSData*)jsonData
              withError:(NSError* _Nullable*)error;

/**
 * @brief
 * @param
 * @param
 * @return
 * @since 0.5.0
 **/
-(BOOL)validateWWWURLEncodedString:(NSString*)encodedString
                         withError:(NSError* _Nullable*)error;



@end
NS_ASSUME_NONNULL_END

