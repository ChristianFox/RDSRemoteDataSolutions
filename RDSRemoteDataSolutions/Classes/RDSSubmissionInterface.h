


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


@end
NS_ASSUME_NONNULL_END
