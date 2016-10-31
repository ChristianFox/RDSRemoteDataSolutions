


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

-(void)dataTaskWithJSONData:(NSData *)jsonData
                        URL:(NSURL *)url
                 HTTPMethod:(NSString*)httpMethod
                 completion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defenses
    NSError *error;
    if (![self.validator validateDestinationURL:url withError:&error]) {
        completionBlock(nil,nil,error);
        return;
    }else if (![self.validator validateJSONData:jsonData withError:&error]) {
        completionBlock(nil,nil,error);
        return;
    }
    
    
    // ## Passed Defenses
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = jsonData;
    request.HTTPMethod = httpMethod;
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
    
    // ## Defenses
    NSError *error;
    if (![self.validator validateDestinationURL:url withError:&error]) {
        completionBlock(nil,nil,error);
        return;
    }else if (![self.validator validateWWWURLEncodedString:urlEncodedString withError:&error]) {
        completionBlock(nil,nil,error);
        return;
    }
    
    // ## Passed Defenses
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = [urlEncodedString dataUsingEncoding:NSUTF8StringEncoding];
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
-(void)setLoggingDelegate:(id<RDSLoggingDelegate>)loggingDelegate{
    @synchronized (_loggingDelegate) {
        if (loggingDelegate != _loggingDelegate) {
            _loggingDelegate = loggingDelegate;
        }
    }
}

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
