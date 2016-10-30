

#import "MOCKNetworkConnector.h"
// Cocoa Categories
#import "NSError+RDSErrors.h"

@implementation MOCKNetworkConnector


//======================================================
#pragma mark - ** Public Methods **
//======================================================

//--------------------------------------------------------
#pragma mark - Submit
//--------------------------------------------------------
-(void)dataTaskWithURL:(NSURL *)url
            completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defenses
    NSError *error;
    if (url == nil) {
        error = [NSError rds_URLIsNilError];
    }
    
    if (error != nil) {
        completionBlock(nil,nil,error);
        return;
    }
    
    // ## Passed Defenses
    NSData *data = [[url absoluteString] dataUsingEncoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:200
                                                            HTTPVersion:@""
                                                           headerFields:nil];
    completionBlock(data,response,error);
    
}

-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defenses
    NSError *error;
    if (url == nil) {
        error = [NSError rds_URLIsNilError];
    }else if (jsonData == nil) {
        error = [NSError rds_jsonDataIsNilError];
    }else if (jsonData.length == 0){
        error = [NSError rds_jsonDataLengthIsZeroError];
    }
    
    if (error != nil) {
        completionBlock(nil,nil,error);
        return;
    }
    
    // ## Passed Defenses
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = jsonData;
    request.HTTPMethod = httpMethod;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSData *data = jsonData;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:200
                                                            HTTPVersion:@""
                                                           headerFields:request.allHTTPHeaderFields];
    completionBlock(data,response,error);
}

-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defenses
    NSError *error;
    if (url == nil) {
        error = [NSError rds_URLIsNilError];
    }else if (urlEncodedString == nil) {
        error = [NSError rds_URLEncodedStringIsNilError];
    }else if (urlEncodedString.length == 0){
        error = [NSError rds_URLEncodedStringLengthIsZeroError];
    }
    
    if (error != nil) {
        completionBlock(nil,nil,error);
        return;
    }
    
    // ## Passed Defenses
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = [urlEncodedString dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    
    NSData *data = request.HTTPBody;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:200
                                                            HTTPVersion:@""
                                                           headerFields:request.allHTTPHeaderFields];
    completionBlock(data,response,error);
}


@end
