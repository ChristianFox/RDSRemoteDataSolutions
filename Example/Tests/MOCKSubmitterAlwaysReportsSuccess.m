

#import "MOCKSubmitterAlwaysReportsSuccess.h"

@implementation MOCKSubmitterAlwaysReportsSuccess

-(void)submitSubmission:(id<RDSSubmissionInterface>)submission withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    NSString *string = @"Success";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:[submission destinationURL]
                                                             statusCode:200
                                                            HTTPVersion:nil
                                                           headerFields:nil];
    completionBlock(data,response,nil);
    
}

@end
