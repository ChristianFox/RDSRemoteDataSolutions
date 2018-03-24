/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

#import <Foundation/Foundation.h>


@interface RDSConstants : NSObject

//--------------------------------------------------------
#pragma mark - Notification Names
//--------------------------------------------------------
extern NSString *const kRDSSubmissionStoredForResubmissionNOTIFICATION;
extern NSString *const kRDSShouldAttemptResubmissionNOTIFICATION;
extern NSString *const kRDSResubmissionProcessCompleteNOTIFICATION;

//--------------------------------------------------------
#pragma mark - Notification Keys
//--------------------------------------------------------
extern NSString *const kRDSResubmissionResultKEY;
extern NSString *const kRDSPendingSubmissionsCountKEY;


@end
