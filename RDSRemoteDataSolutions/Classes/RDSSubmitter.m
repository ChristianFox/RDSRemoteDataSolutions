

#import "RDSSubmitter.h"
// Components
#import "RDSNetworkConnector.h"
// Helpers
#import "RDSHelper.h"
// Categories
#import "NSError+RDSErrors.h"


@interface RDSSubmitter ()
@property (strong,nonatomic,readwrite) id<RDSNetworkConnectorInterface> networkConnector;
@property (strong,nonatomic) RDSHelper *helper;
@end

@implementation RDSSubmitter


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)defaultSubmitter{
    
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    RDSSubmitter *submitter = [self submitterWithNetworkConnector:connector];
    return submitter;
}

+(instancetype)submitterWithNetworkConnector:(id<RDSNetworkConnectorInterface>)networkConnector{
    if (networkConnector == nil) {
        return nil;
    }
    RDSSubmitter *submitter = [[self alloc]init];
    submitter.networkConnector = networkConnector;
    return submitter;
}

//--------------------------------------------------------
#pragma mark - Submissions
//--------------------------------------------------------
-(void)submitSubmission:(id<RDSSubmissionInterface>)submission
         withCompletion:(RDSNetworkResponseCompletionBlock)completionBlock{
    
    // ## Defensive
    NSError *error;
    if (submission == nil) {
        error = [NSError rds_submissionIsNilError];
    }else if ([submission destinationURL] == nil){
        error = [NSError rds_submissionURLIsNilError];
    }else if ([submission submissionContentType] == RDSSubmissionContentTypeUndefined){
        error = [NSError rds_SubmissionContentTypeIsUndefined];
    }
    
    if (error != nil) {
        completionBlock(nil,nil,error);
        return;
    }
    
    // ## Passed Defenses
    if ([submission submissionContentType] == RDSSubmissionContentTypeNone) {
        
        [self.networkConnector dataTaskWithURL:[submission destinationURL]
                                    completion:completionBlock];
        
    }else{
        NSDictionary *params;
        if ([submission respondsToSelector:@selector(parameters)]) {
            params = [submission parameters];
        }
        if (params == nil) {
            error = [NSError rds_submissionParametersIsNil];
            completionBlock(nil,nil,error);
            return;
        }
        
        NSString *HTTPMethod;
        if ([submission respondsToSelector:@selector(HTTPMethod)]) {
            HTTPMethod = [submission HTTPMethod];
        }

        if ([submission submissionContentType] == RDSSubmissionContentTypeJSONData) {
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:kNilOptions
                                                                 error:&error];
            if (jsonData == nil) {
                completionBlock(nil,nil,error);
                return;
            }
            [self.networkConnector dataTaskWithJSONData:jsonData
                                                    URL:[submission destinationURL]
                                             HTTPMethod:HTTPMethod
                                             completion:completionBlock];

            
        }else if ([submission submissionContentType] == RDSSubmissionContentTypeWWWURLEncodedString){
            
            NSString *encodedString = [self.helper wwwFormURLEncodedStringFromParameters:params];
            [self.networkConnector dataTaskWithURLEncodedString:encodedString
                                                            URL:[submission destinationURL]
                                                     HTTPMethod:HTTPMethod
                                                     completion:completionBlock];
            
        }
    }
    
    
}



//======================================================
#pragma mark - ** Inherited Methods **
//======================================================




//======================================================
#pragma mark - ** Protocol Methods **
//======================================================




//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
-(RDSHelper *)helper{
    if (!_helper) {
        _helper = [RDSHelper helper];
    }
    return _helper;
}



@end
