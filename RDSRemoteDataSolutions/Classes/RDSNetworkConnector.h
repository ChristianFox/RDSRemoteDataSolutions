


#import <Foundation/Foundation.h>
// Protocols
#import "RDSNetworkConnectorInterface.h"
#import "RDSLoggingDelegate.h"
// Other
@class RDSValidator;

@interface RDSNetworkConnector : NSObject <RDSNetworkConnectorInterface>

@property (weak, atomic) id<RDSLoggingDelegate> loggingDelegate;
@property (strong, atomic) RDSValidator *validator;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
/**
 * @brief Convinience initiliser
 * @return An instance of RDSHelper
 * @since 0.2.0
 **/
+(instancetype)networkConnector;

@end
