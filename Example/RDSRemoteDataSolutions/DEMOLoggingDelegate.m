


#import "DEMOLoggingDelegate.h"
// Pods
#import <KFXLog/KFXLog.h>

@implementation DEMOLoggingDelegate

-(void)logInfo:(NSString*)info{
    [KFXLog logInfoWithSender:self format:@"_RDS_: %@",info];
}

-(void)logNotice:(NSString*)notice{
    [KFXLog logNoticeWithSender:self format:@"_RDS_: %@",notice];
}

-(void)logFail:(NSString*)fail{
    [KFXLog logFailWithSender:self format:@"_RDS_: %@",fail];
}

-(void)logWarning:(NSString*)warning{
    [KFXLog logWarningWithSender:self format:@"_RDS_: %@",warning];
}

-(void)logError:(NSError*)error{
    [KFXLog logErrorIfExists:error sender:self];
}


@end
