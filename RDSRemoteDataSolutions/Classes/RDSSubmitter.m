

#import "RDSSubmitter.h"
// Components
#import "RDSNetworkConnector.h"
// Categories
#import "NSError+RDSErrors.h"

@interface RDSSubmitter ()
@property (strong,nonatomic,readwrite) id<RDSNetworkConnectorInterface> networkConnector;
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
        
        if ([submission parameters] == nil) {
            error = [NSError rds_submissionParametersIsNil];
            completionBlock(nil,nil,error);
            return;
        }

        if ([submission submissionContentType] == RDSSubmissionContentTypeJSONData) {
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[submission parameters]
                                                               options:kNilOptions
                                                                 error:&error];
            if (jsonData == nil) {
                completionBlock(nil,nil,error);
                return;
            }
            [self.networkConnector dataTaskWithJSONData:jsonData
                                                    URL:[submission destinationURL]
                                             HTTPMethod:[submission HTTPMethod]
                                             completion:completionBlock];

            
        }else if ([submission submissionContentType] == RDSSubmissionContentTypeWWWURLEncodedString){
            
            
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




@end
