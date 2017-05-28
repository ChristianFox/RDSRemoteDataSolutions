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

@protocol RDSLoggingDelegate <NSObject>

@optional

-(void)logInfo:(NSString*)info;
-(void)logNotice:(NSString*)notice;
-(void)logFail:(NSString*)fail;
-(void)logWarning:(NSString*)warning;
-(void)logError:(NSError*)error;

@end
