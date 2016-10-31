


#import <Foundation/Foundation.h>

@interface NSError (RDSErrors)

+(instancetype)rds_submissionIsNilError;
+(instancetype)rds_submissionDoesNotConformToNSCoding;
+(instancetype)rds_submissionURLIsNilError;
+(instancetype)rds_submissionParametersIsNil;
+(instancetype)rds_SubmissionContentTypeIsUndefined;
+(instancetype)rds_jsonDataIsNilError;
+(instancetype)rds_jsonDataLengthIsZeroError;
+(instancetype)rds_URLEncodedStringIsNilError;
+(instancetype)rds_URLEncodedStringLengthIsZeroError;
+(instancetype)rds_URLIsNilError;

@end
