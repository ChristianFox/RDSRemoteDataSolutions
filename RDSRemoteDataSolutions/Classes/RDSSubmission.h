/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/


@import Foundation;
#import <RDSRemoteDataSolutions/RDSSubmissionInterface.h>

NS_ASSUME_NONNULL_BEGIN
@interface RDSSubmission : NSObject <RDSSubmissionInterface>

@property (strong,atomic,nullable) NSURL *destinationURL;
@property (strong,atomic,nullable) NSDictionary *parameters;
@property (atomic) RDSSubmissionContentType submissionContentType;
@property (strong,atomic,nullable) NSString *HTTPMethod;
@property (nonatomic) BOOL shouldScheduleForResubmissionOnFailure;

+(instancetype)submission;

@end
NS_ASSUME_NONNULL_END
