


#import "RDSValidator.h"
// Cocoa Categories
#import "NSError+RDSErrors.h"

@implementation RDSValidator


//======================================================
#pragma mark - ** Private Method **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilise
//--------------------------------------------------------
+(instancetype)validator{
    RDSValidator *validator = [[self alloc]init];
    return validator;
}

//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - RDSValidationDelegate
//--------------------------------------------------------
-(BOOL)validateSubmission:(id<RDSSubmissionInterface>)submission
                withError:(NSError *__autoreleasing  _Nullable *)error{
    
    BOOL isValid = NO;
    NSError *localError;
    if (submission == nil) {
        
        isValid = NO;
        localError = [NSError rds_submissionIsNilError];
        
    }else if (![submission conformsToProtocol:@protocol(NSCoding)]){
        
        isValid = NO;
        localError = [NSError rds_submissionDoesNotConformToNSCoding];

    }else if ([submission destinationURL] == nil){
        
        isValid = NO;
        localError = [NSError rds_submissionURLIsNilError];
        
    }else{
        
        isValid = YES;
    }
    
    if (!isValid) {
        if (error != nil) {
            *error = localError;
        }
    }
    
    return isValid;
}

-(BOOL)validateDestinationURL:(NSURL *)url
                    withError:(NSError *__autoreleasing  _Nullable *)error{
    
    BOOL isValid = NO;
    NSError *localError;

    if (url == nil) {
        
        isValid = NO;
        localError = [NSError rds_URLIsNilError];
        
    }else{
        
        isValid = YES;
    }
    
    if (!isValid) {
        if (error != nil) {
            *error = localError;
        }
    }

    return isValid;
}

-(BOOL)validateParameters:(NSDictionary *)parameters
                withError:(NSError *__autoreleasing  _Nullable *)error{
    
    BOOL isValid = NO;
    
    NSError *localError;
    if (parameters == nil) {
        
        isValid = NO;
        localError = [NSError rds_submissionParametersIsNil];
        
    }else{
        
        isValid = YES;
    }
    
    if (!isValid) {
        if (error != nil) {
            *error = localError;
        }
    }
    
    return isValid;
}

-(BOOL)validateJSONData:(NSData *)jsonData
              withError:(NSError *__autoreleasing  _Nullable *)error{
    
    BOOL isValid = NO;
    NSError *localError;
    if (jsonData == nil) {
        
        isValid = NO;
        localError = [NSError rds_jsonDataIsNilError];
     
    }else if (jsonData.length == 0){
        
        isValid = NO;
        localError = [NSError rds_jsonDataLengthIsZeroError];

    }else{
        
        isValid = YES;
    }
    
    if (!isValid) {
        if (error != nil) {
            *error = localError;
        }
    }

    return isValid;
}

-(BOOL)validateWWWURLEncodedString:(NSString *)encodedString
                         withError:(NSError *__autoreleasing  _Nullable *)error{
    
    BOOL isValid = NO;
    NSError *localError;
    
    if (encodedString == nil) {
        
        isValid = NO;
        localError = [NSError rds_URLEncodedStringIsNilError];
        
    }else if (encodedString.length == 0){
        
        isValid = NO;
        localError = [NSError rds_URLEncodedStringLengthIsZeroError];
        
    }else{
        
        isValid = YES;
    }
    
    if (!isValid) {
        if (error != nil) {
            *error = localError;
        }
    }

    return isValid;
}




@end















