


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
