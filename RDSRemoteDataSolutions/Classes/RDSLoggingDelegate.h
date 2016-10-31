

#import <Foundation/Foundation.h>

@protocol RDSLoggingDelegate <NSObject>

@optional

-(void)logInfo:(NSString*)info;
-(void)logNotice:(NSString*)notice;
-(void)logFail:(NSString*)fail;
-(void)logWarning:(NSString*)warning;
-(void)logError:(NSError*)error;

@end
