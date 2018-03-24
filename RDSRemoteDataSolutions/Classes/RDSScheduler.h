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
// Protocols
#import "RDSLoggingDelegate.h"

extern NSTimeInterval const kDefaultMinimumTimeTillNextSubmissionAttempt;
extern NSTimeInterval const kDefaultMaximumTimeTillNextSubmissionAttempt;
extern NSTimeInterval const kDefaultMultiplierOfTimeTillNextSubmissionAttempt;


@interface RDSScheduler : NSObject


@property (weak, atomic) id<RDSLoggingDelegate> loggingDelegate;
/// The minimum time between one submission attempt and the next. The scheduler timer will be set to this value in the first instance, then after each re-set it will be set to this value * the multiplier value until it reaches the maximum value. Defaults to 5.0
@property (atomic,readonly) NSTimeInterval minimumTimeTillNextSubmissionAttempt;
/// The maximum time between one submission attempt and the next. The time between submission attempts will never be set to be longer than this time interval (not counting for periods of app suspension longer than this period). Defaults to 36000.0 (10 hrs)
@property (atomic,readonly) NSTimeInterval maximumTimeTillNextSubmissionAttempt;
/// The multiplier to be used to increase the time between each submission attempt. Every time the timer is re-set it will be set to fire in a period of seconds equal to this value * the previous timer fire time interval. Defaults to 5.0.
@property (atomic,readonly) NSTimeInterval multiplierOfTimeTillNextSubmissionAttempt;
/// The time interval to wait between submission attempts. This value is the product of the previous timeIntervalBetweenSubmissionAttempts and multiplierOfTimeTillNextSubmissionAttempt. Defaults to minimumTimeTillNextSubmissionAttempt.
@property (atomic, readonly) NSTimeInterval timeIntervalBetweenSubmissionAttempts;
/// The number of failed submission attempts made since the last successful attempt. Defaults to 0. If no successful attempts have been made then we count still.
@property (atomic, readonly) NSInteger failedSubmissionAttemptsSinceLastSuccess;
/// Is a submission attempt already scheduled
@property (atomic,getter=isSubmissionAttemptScheduled, readonly) BOOL submissionAttemptScheduled;


//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init NS_UNAVAILABLE;

/**
 * @brief Convinience initiliser for an instance with default settings
 * @return An instance of RDSScheduler
 * @since 0.4.0
 **/
+(instancetype)defaultScheduler;

/**
 * @brief Convinience initiliser for an instance with custom settings
 * @param minimum set the minimumTimeTillNextSubmissionAttempt
 * @param maximum set the maximumTimeTillNextSubmissionAttempt
 * @param multiplier set the multiplierOfTimeTillNextSubmissionAttempt
 * @return An instance of RDSScheduler
 * @since 0.4.0
 **/
+(instancetype)schedulerWithMinimumTimeBetweenSubmissionAttempts:(NSTimeInterval)minimum
                                      maximumTimeBetweenAttempts:(NSTimeInterval)maximum
                                 multiplierOfTimeBetweenAttempts:(NSTimeInterval)multiplier;

//--------------------------------------------------------
#pragma mark - Queries
//--------------------------------------------------------
/**
 * @brief Get the number seconds until the receiver will next attempt to trigger the resubmissions process.
 * @return An NSTimeInterval with the number of seconds until any stored submissions will next be submitted.
 * @since 0.4.0
 **/
-(NSTimeInterval)timeIntervalTillNextSubmissionAttempt;



@end
