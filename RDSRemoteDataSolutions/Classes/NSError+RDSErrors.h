/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/


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
