

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
+(instancetype)defaultSubmissionStation;
+(instancetype)submissionStationWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector;


//--------------------------------------------------------
#pragma mark - Submission
//--------------------------------------------------------
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock;



@end
NS_ASSUME_NONNULL_END
