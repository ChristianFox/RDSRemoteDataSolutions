

#import "RDSScheduler.h"
// Constants
#import "RDSConstants.h"

NSTimeInterval const kDefaultMinimumTimeTillNextSubmissionAttempt = 5.0;
NSTimeInterval const kDefaultMaximumTimeTillNextSubmissionAttempt = 36000.0;
NSTimeInterval const kDefaultMultiplierOfTimeTillNextSubmissionAttempt = 5.0;


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
    
    NSNotification *note = [NSNotification notificationWithName:kRDSShouldAttemptResubmissionNOTIFICATION
                                                         object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:note];
}

-(void)resetTimer{
    
    self.submissionsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeIntervalBetweenSubmissionAttempts
                                                             target:self
                                                           selector:@selector(submissionTimerDidFire:)
                                                           userInfo:nil
                                                            repeats:NO];
}




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











