/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

#import "RDSScheduler.h"
// Constants
#import "RDSConstants.h"

NSTimeInterval const kDefaultMinimumTimeTillNextSubmissionAttempt = 5.0;
NSTimeInterval const kDefaultMaximumTimeTillNextSubmissionAttempt = 36000.0;
NSTimeInterval const kDefaultMultiplierOfTimeTillNextSubmissionAttempt = 1.0;


@interface RDSScheduler ()

@property (strong,atomic,nullable) NSTimer *submissionsTimer;
@property (atomic,readwrite) NSTimeInterval minimumTimeTillNextSubmissionAttempt;
@property (atomic,readwrite) NSTimeInterval maximumTimeTillNextSubmissionAttempt;
@property (atomic,readwrite) NSTimeInterval multiplierOfTimeTillNextSubmissionAttempt;
@property (atomic,readwrite) NSTimeInterval timeIntervalBetweenSubmissionAttempts;
@property (atomic,readwrite) NSInteger failedSubmissionAttemptsSinceLastSuccess;
@property (atomic,getter=isSubmissionAttemptScheduled,readwrite) BOOL submissionAttemptScheduled;
@end

@implementation RDSScheduler

dispatch_queue_t schedulerQueue;


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)defaultScheduler{
    RDSScheduler *scheduler =
    [self schedulerWithMinimumTimeBetweenSubmissionAttempts:kDefaultMinimumTimeTillNextSubmissionAttempt
                                 maximumTimeBetweenAttempts:kDefaultMaximumTimeTillNextSubmissionAttempt
                            multiplierOfTimeBetweenAttempts:kDefaultMultiplierOfTimeTillNextSubmissionAttempt];
    return scheduler;
}

+(instancetype)schedulerWithMinimumTimeBetweenSubmissionAttempts:(NSTimeInterval)minimum
                                      maximumTimeBetweenAttempts:(NSTimeInterval)maximum
                                 multiplierOfTimeBetweenAttempts:(NSTimeInterval)multiplier{
    RDSScheduler *scheduler = [[self alloc]init];
    [scheduler registerForNotifications];
    scheduler.minimumTimeTillNextSubmissionAttempt = minimum;
    scheduler.maximumTimeTillNextSubmissionAttempt = maximum;
    scheduler.multiplierOfTimeTillNextSubmissionAttempt = multiplier;
    scheduler.timeIntervalBetweenSubmissionAttempts = minimum;
    scheduler.submissionAttemptScheduled = NO;
    schedulerQueue = dispatch_queue_create("com.kfxtech.rdsremotedatasolutions.scheduler", NULL);
    return scheduler;
    
}


//--------------------------------------------------------
#pragma mark - Queries
//--------------------------------------------------------
-(NSTimeInterval)timeIntervalTillNextSubmissionAttempt{
    if (!self.isSubmissionAttemptScheduled) {
        return 0.0;
    }
    NSDate *fireDate = self.submissionsTimer.fireDate;
    NSTimeInterval timeTillFire = [fireDate timeIntervalSinceDate:[NSDate date]];
    return timeTillFire;
}



//======================================================
#pragma mark - ** Inherited Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - NSObject
//--------------------------------------------------------
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}






//======================================================
#pragma mark - ** Private Methods **
//======================================================
-(void)submissionTimerDidFire:(NSTimer*)timer{
    
    if ([self.loggingDelegate respondsToSelector:@selector(logInfo:)]){
        NSString *message = @"RDSScheduler Resubmission Timer did fire - time to attempt resubmission";
        [self.loggingDelegate logInfo:message];
    }
    
    NSNotification *note = [NSNotification notificationWithName:kRDSShouldAttemptResubmissionNOTIFICATION
                                                         object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:note];
}

-(void)resetTimer{
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeIntervalBetweenSubmissionAttempts
                                             target:self
                                           selector:@selector(submissionTimerDidFire:)
                                           userInfo:nil
                                            repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.submissionsTimer = timer;
    
    
//    dispatch_async(schedulerQueue, ^{
//        
//        self.submissionsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeIntervalBetweenSubmissionAttempts
//                                                                 target:self
//                                                               selector:@selector(submissionTimerDidFire:)
//                                                               userInfo:nil
//                                                                repeats:NO];
        // Log
        if ([self.loggingDelegate respondsToSelector:@selector(logInfo:)]) {
            
            NSString *message = [NSString stringWithFormat:@"RDSScheduler submissionTimer has been reset to fire in %f seconds",self.timeIntervalBetweenSubmissionAttempts];
            [self.loggingDelegate logInfo:message];
        }
//
//    });
}

//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------


//--------------------------------------------------------
#pragma mark - Notifications
//--------------------------------------------------------
-(void)registerForNotifications{
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didReceiveSubmissionStoredForResubmissionNotification:)
                                                name:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didReceiveResubmissionProcessCompleteNotification:)
                                                name:kRDSResubmissionProcessCompleteNOTIFICATION
                                              object:nil];
    
}

-(void)didReceiveSubmissionStoredForResubmissionNotification:(NSNotification*)note{
    
    if (!self.isSubmissionAttemptScheduled) {
        self.submissionAttemptScheduled = YES;
        [self resetTimer];
    }
    
}

-(void)didReceiveResubmissionProcessCompleteNotification:(NSNotification*)note{
    
    BOOL success = NO;
    success = [note.userInfo[kRDSResubmissionResultKEY] boolValue];
    if (!success) {
        
        if (!self.isSubmissionAttemptScheduled) {
            // If receiving this notification then submissionAttemptScheduled should be YES but if it is not then set it to YES.
            self.submissionAttemptScheduled = YES;
            
        }else{
        
            self.timeIntervalBetweenSubmissionAttempts *= self.multiplierOfTimeTillNextSubmissionAttempt;
            if (self.timeIntervalBetweenSubmissionAttempts > self.maximumTimeTillNextSubmissionAttempt) {
                self.timeIntervalBetweenSubmissionAttempts = self.maximumTimeTillNextSubmissionAttempt;
            }
        }
        
        [self resetTimer];
        
    }else{
        
        self.submissionAttemptScheduled = NO;
        [self.submissionsTimer invalidate];
        self.submissionsTimer = nil;
        self.timeIntervalBetweenSubmissionAttempts = self.minimumTimeTillNextSubmissionAttempt;
        
    }
}





@end











