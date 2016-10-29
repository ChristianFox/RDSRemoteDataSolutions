

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
    if (submission == nil) {
        NSError *error = [NSError rds_submissionIsNilError];
        completionBlock(nil,nil,error);
        return;
    }else if ([submission destinationURL] == nil){
        NSError *error = [NSError rds_submissionURLIsNilError];
        completionBlock(nil,nil,error);
        return;
    }
    
    
    // ## Passed Defenses
    
    
    
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
