/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/


#import "RDSNetworkConnector.h"
// Cocoa Categories
#import "NSError+RDSErrors.h"
//
#import "RDSValidator.h"

@interface RDSNetworkConnector ()
@property (strong,nonatomic) NSURLSession *session;
@end


@implementation RDSNetworkConnector

@synthesize validator = _validator;

//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)networkConnector{
    RDSNetworkConnector *connector = [[self alloc]init];
    return connector;
}

//--------------------------------------------------------
#pragma mark - Submit
//--------------------------------------------------------
-(void)dataTaskWithURL:(NSURL *)url
            completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defenses
    NSError *error;
    if (![self.validator validateDestinationURL:url withError:&error]) {
        completionBlock(nil,nil,error);
        return;
    }
    
    
    // ## Passed Defenses
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     completionBlock(data,response,error);
                     
                 }]resume];
    
    
}


-(void)dataTaskWithURL:(NSURL *)url
additionalHeaderFields:(NSDictionary<NSString *,NSString *> *)additionalHeaderFields
            HTTPMethod:(NSString*)httpMethod
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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = httpMethod;
    [request setAllHTTPHeaderFields:additionalHeaderFields];
    
    // ## Passed Defenses
    [[self.session dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         
                         completionBlock(data,response,error);
                         
                     }]resume];
    
    
}

-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    

    [self dataTaskWithJSONData:jsonData
                           URL:url
        additionalHeaderFields:nil
                    HTTPMethod:httpMethod
                    completion:completionBlock];
}

-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
     additionalHeaderFields:(NSDictionary<NSString*,NSString*>*)additionalHeaderFields
                 HTTPMethod:(NSString *)httpMethod completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
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
    if (additionalHeaderFields != nil) {
        [request setAllHTTPHeaderFields:additionalHeaderFields];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[self.session dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         completionBlock(data,response,error);
                         
                     }]resume];
    
}


-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
                         HTTPMethod:(NSString*)httpMethod
                         completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    

    [self dataTaskWithURLEncodedString:urlEncodedString
                                   URL:url
                additionalHeaderFields:nil
                            HTTPMethod:httpMethod
                            completion:completionBlock];
}

-(void)dataTaskWithURLEncodedString:(NSString *)urlEncodedString
                                URL:(NSURL *)url
             additionalHeaderFields:(NSDictionary<NSString*,NSString*>*)additionalHeaderFields
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
    if (additionalHeaderFields != nil) {
        [request setAllHTTPHeaderFields:additionalHeaderFields];
    }
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    
    
    [[self.session dataTaskWithRequest:request
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         completionBlock(data,response,error);
                         
                     }]resume];
}

//--------------------------------------------------------
#pragma mark - Accessors
//--------------------------------------------------------

-(void)setValidator:(RDSValidator *)validator{
    @synchronized (_validator) {
        if (validator != _validator) {
            _validator = validator;
        }
    }
}

-(RDSValidator *)validator{
    RDSValidator *validator;
    @synchronized (_validator) {
        if (!_validator) {
            _validator = [RDSValidator validator];
        }
        validator = _validator;
    }
    return validator;
}



//======================================================
#pragma mark - ** Inherited Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - NSObject
//--------------------------------------------------------
-(void)dealloc{
    [self.session finishTasksAndInvalidate];
}




//======================================================
#pragma mark - ** Protocol Methods **
//======================================================




//======================================================
#pragma mark - ** Private Methods **
//======================================================


//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
//--------------------------------------------------------
-(NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        _session = session;
    }
    return _session;
}

//--------------------------------------------------------
#pragma mark - Dealloc
//--------------------------------------------------------


@end
