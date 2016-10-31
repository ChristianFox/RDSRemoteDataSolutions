


#import "DEMOLoggingDelegate.h"


@implementation DEMOLoggingDelegate

-(void)logInfo:(NSString*)info{
    NSLog(@"__RDS__ <INFO> %@",info);
}

-(void)logNotice:(NSString*)notice{
    NSLog(@"__RDS__ <NOTICE> %@",notice);
}

-(void)logFail:(NSString*)fail{
    NSLog(@"__RDS__ <FAIL> %@",fail);
}

-(void)logWarning:(NSString*)warning{
    NSLog(@"__RDS__ <WARNING> %@",warning);
}

-(void)logError:(NSError*)error{
    NSLog(@"__RDS__ <ERROR> %ld, %@",error.code,error.localizedDescription);
}


@end
