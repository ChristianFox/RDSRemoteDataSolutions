


#import "NSError+RDSErrors.h"
#import "RDSDefinitions.h"

static NSString *kErrorDomain = @"com.KFXTech.RDSRemoteDataSolutions";


@implementation NSError (RDSErrors)

+(instancetype)rds_submissionIsNilError{
    NSString *message = NSLocalizedString(@"Can not submit the RDSSubmissionInterface conforming instance because it is nil", @"Can not submit the RDSSubmissionInterface conforming instance because it is nil");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorSubmissionIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
    
}

+(instancetype)rds_submissionURLIsNilError{
    
    NSString *message = NSLocalizedString(@"Can not submit the RDSSubmissionInterface conforming instance because it's destination URL is nil", @"Can not submit the RDSSubmissionInterface conforming instance because it's destination URL is nil");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorSubmissionURLIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}

+(instancetype)rds_submissionParametersIsNil{
    NSString *message = NSLocalizedString(@"The submission's parameters is nil, it must be defined so the submission can be completed", @"The submission's parameters is undefined, it must be defined so the submission can be completed");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorSubmissionParametersIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}

+(instancetype)rds_SubmissionContentTypeIsUndefined{
    NSString *message = NSLocalizedString(@"The submission's submissionContentType is undefined, it must be defined so the submission can be completed", @"The submission's submissionContentType is undefined, it must be defined so the submission can be completed");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorSubmissionContentTypeIsUndefined
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}


+(instancetype)rds_jsonDataIsNilError{
    NSString *message = NSLocalizedString(@"jsonData is nil", @"jsonData is nil");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorJSONDataIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;

}

+(instancetype)rds_jsonDataLengthIsZeroError{
    NSString *message = NSLocalizedString(@"jsonData length is 0", @"jsonData length is 0");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorJSONDataLengthIsZero
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;

}

+(instancetype)rds_URLEncodedStringIsNilError{
    NSString *message = NSLocalizedString(@"URLEncodedString is nil", @"URLEncodedString is nil");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorURLEncodedStringIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}

+(instancetype)rds_URLEncodedStringLengthIsZeroError{
    NSString *message = NSLocalizedString(@"URLEncodedString length is 0", @"URLEncodedString length is 0");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorURLEncodedStringLengthIsZero
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}

+(instancetype)rds_URLIsNilError{
    NSString *message = NSLocalizedString(@"URL is nil", @"URL is nil");
    NSError *error = [self errorWithDomain:kErrorDomain
                                      code:RDSErrorURLIsNil
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}




@end
























