/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/


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
