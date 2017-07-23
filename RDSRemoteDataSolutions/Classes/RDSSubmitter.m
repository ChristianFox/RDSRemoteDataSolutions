/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

#import "RDSSubmitter.h"
// Components
#import "RDSNetworkConnector.h"
#import "RDSValidator.h"
// Helpers
#import "RDSHelper.h"
// Categories
#import "NSError+RDSErrors.h"


@interface RDSSubmitter ()
@property (strong,nonatomic,readwrite) id<RDSNetworkConnectorInterface> networkConnector;
@property (strong,nonatomic) RDSHelper *helper;
@end

@implementation RDSSubmitter

@synthesize validator = _validator;
@synthesize loggingDelegate = _loggingDelegate;

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
    

    // ## Passed Defenses
    if ([submission submissionContentType] == RDSSubmissionContentTypeNone) {
        
        [self.networkConnector dataTaskWithURL:[submission destinationURL]
                                    completion:completionBlock];
        
    }else{
        NSDictionary *params;
        if ([submission respondsToSelector:@selector(parameters)]) {
            params = [submission parameters];
        }
        NSError *error;
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
            
            NSString *encodedString = [RDSHelper wwwFormURLEncodedStringFromParameters:params];
            [self.networkConnector dataTaskWithURLEncodedString:encodedString
                                                            URL:[submission destinationURL]
                                                     HTTPMethod:HTTPMethod
                                                     completion:completionBlock];
            
        }
    }
    
    
}



//--------------------------------------------------------
#pragma mark - Accessors
//--------------------------------------------------------
-(void)setLoggingDelegate:(id<RDSLoggingDelegate>)loggingDelegate{
    @synchronized (_loggingDelegate) {
        if (loggingDelegate != _loggingDelegate) {
            _loggingDelegate = loggingDelegate;
            if ([self.networkConnector respondsToSelector:@selector(setLoggingDelegate:)]) {
                [self.networkConnector performSelector:@selector(setLoggingDelegate:) withObject:loggingDelegate];
            }
        }
    }
}

-(id<RDSLoggingDelegate>)loggingDelegate{
    id<RDSLoggingDelegate> delegate;
    @synchronized (_loggingDelegate) {
        delegate = _loggingDelegate;
    }
    return delegate;

}

-(void)setValidator:(RDSValidator *)validator{
    @synchronized (_validator) {
        if (validator != _validator) {
            _validator = validator;
            if ([self.networkConnector respondsToSelector:@selector(setValidator:)]) {
                [self.networkConnector performSelector:@selector(setValidator:) withObject:validator];
            }

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
