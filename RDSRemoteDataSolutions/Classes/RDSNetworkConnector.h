


#import <Foundation/Foundation.h>
#import "RDSNetworkConnectorInterface.h"

@interface RDSNetworkConnector : NSObject <RDSNetworkConnectorInterface>

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
