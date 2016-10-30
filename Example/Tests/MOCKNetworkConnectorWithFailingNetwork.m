

#import "MOCKNetworkConnectorWithFailingNetwork.h"
// Cocoa Categories
#import "NSError+RDSErrors.h"

@implementation MOCKNetworkConnectorWithFailingNetwork



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
    NSData *data = nil;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:404
                                                            HTTPVersion:@""
                                                           headerFields:nil];
    error = [NSError errorWithDomain:@"com.kfxtech.mockNetworkIssue"
                                code:1234
                            userInfo:@{NSLocalizedDescriptionKey:@"This error represents a mock of a failure to connect"}];
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
    NSData *data = nil;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:404
                                                            HTTPVersion:@""
                                                           headerFields:nil];
    error = [NSError errorWithDomain:@"com.kfxtech.mockNetworkIssue"
                                code:1234
                            userInfo:@{NSLocalizedDescriptionKey:@"This error represents a mock of a failure to connect"}];
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
    NSData *data = nil;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:url
                                                             statusCode:404
                                                            HTTPVersion:@""
                                                           headerFields:nil];
    error = [NSError errorWithDomain:@"com.kfxtech.mockNetworkIssue"
                                code:1234
                            userInfo:@{NSLocalizedDescriptionKey:@"This error represents a mock of a failure to connect"}];
    completionBlock(data,response,error);
}

@end
