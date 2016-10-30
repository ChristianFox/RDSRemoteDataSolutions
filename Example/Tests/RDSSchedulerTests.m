


#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSScheduler.h>
// Constants
#import <RDSRemoteDataSolutions/RDSConstants.h>

@interface RDSSchedulerTests : XCTestCase

@end

@implementation RDSSchedulerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



//--------------------------------------------------------
#pragma mark - Test Initilisers
//--------------------------------------------------------
-(void)testDefaultSchedulerConvienenceIntitiliser{
    RDSScheduler *scheduler = [RDSScheduler defaultScheduler];
    XCTAssertNotNil(scheduler);
}

-(void)testSchedulerWithTimeIntervalsConvienceInitiliser{
    NSTimeInterval min = 11.0;
    NSTimeInterval max = 2222.0;
    NSTimeInterval multi = 4.0;
    RDSScheduler *scheduler = [RDSScheduler schedulerWithMinimumTimeBetweenSubmissionAttempts:min
                                                                   maximumTimeBetweenAttempts:max
                                                              multiplierOfTimeBetweenAttempts:multi];
    XCTAssertNotNil(scheduler);
    XCTAssertEqual(min, scheduler.minimumTimeTillNextSubmissionAttempt);
    XCTAssertEqual(max, scheduler.maximumTimeTillNextSubmissionAttempt);
    XCTAssertEqual(multi, scheduler.multiplierOfTimeTillNextSubmissionAttempt);
}


//--------------------------------------------------------
#pragma mark - Test
//--------------------------------------------------------
-(void)testSchedulerPostsShouldResubmitNotificationAfterReceivingSubmissionStoredForResubmissionNotification{
    
    // Expect
    [self expectationForNotification:kRDSShouldAttemptResubmissionNOTIFICATION
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 // THEN
                                 return YES;
                             }];

    // GIVEN
    NSTimeInterval min = 2.0;
    NSTimeInterval max = 20.0;
    NSTimeInterval multi = 2.0;
    RDSScheduler *scheduler = [RDSScheduler schedulerWithMinimumTimeBetweenSubmissionAttempts:min
                                                                   maximumTimeBetweenAttempts:max
                                                              multiplierOfTimeBetweenAttempts:multi];
    XCTAssertNotNil(scheduler);
    
    // WHEN
    NSNotification *note = [NSNotification notificationWithName:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                                         object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    
    // Wait
    [self waitForExpectationsWithTimeout:min+1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testSchedulerChangesToIsScheduledAfterReceivingResubmissionProcessCompletionNotificationWithFailedResult_ShouldHaveAttemptScheduled{
    
    // GIVEN
    NSTimeInterval min = 2.0;
    NSTimeInterval max = 20.0;
    NSTimeInterval multi = 2.0;
    RDSScheduler *scheduler = [RDSScheduler schedulerWithMinimumTimeBetweenSubmissionAttempts:min
                                                                   maximumTimeBetweenAttempts:max
                                                              multiplierOfTimeBetweenAttempts:multi];
    XCTAssertNotNil(scheduler);
    XCTAssertFalse(scheduler.isSubmissionAttemptScheduled);
    
    // WHEN
    NSNotification *note = [NSNotification notificationWithName:kRDSResubmissionProcessCompleteNOTIFICATION
                                                         object:nil
                                                       userInfo:@{kRDSResubmissionResultKEY:@(NO)}];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    
    // THEN
    XCTAssertTrue(scheduler.isSubmissionAttemptScheduled);
}


-(void)testSchedulerChangesToIsNotScheduledAfterReceivingResubmissionProcessCompletionNotificationWithSuccessResult_ShouldNotHaveAttemptScheduled{
    
    // GIVEN
    NSTimeInterval min = 5.0;
    NSTimeInterval max = 20.0;
    NSTimeInterval multi = 2.0;
    RDSScheduler *scheduler = [RDSScheduler schedulerWithMinimumTimeBetweenSubmissionAttempts:min
                                                                   maximumTimeBetweenAttempts:max
                                                              multiplierOfTimeBetweenAttempts:multi];
    XCTAssertNotNil(scheduler);
    XCTAssertFalse(scheduler.isSubmissionAttemptScheduled);
    
    // WHEN
    // Post note to get submission scheduled
    NSNotification *startNote = [NSNotification notificationWithName:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                                         object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:startNote];
    XCTAssertTrue(scheduler.isSubmissionAttemptScheduled);
    XCTAssertTrue([scheduler timeIntervalTillNextSubmissionAttempt] > 1.0);

    // Post note to say has completed successfully which should stop scheduling
    NSNotification *stopNote = [NSNotification notificationWithName:kRDSResubmissionProcessCompleteNOTIFICATION
                                                         object:nil
                                                       userInfo:@{kRDSResubmissionResultKEY:@(YES)}];
    [[NSNotificationCenter defaultCenter]postNotification:stopNote];
    
    // THEN
    XCTAssertFalse(scheduler.isSubmissionAttemptScheduled);
    XCTAssertEqual([scheduler timeIntervalTillNextSubmissionAttempt], 0.0);
}


-(void)testThatAfterSchedulerSubmissionsTimerHasFired_AndSchedulerHasReceivedResubmissionFailedNotification_ShouldHaveATimeTillResubmissionAttemptThatIsRoughlyEqualToMinTimeMultipledByMultiplier{
    
    
    // GIVEN
    NSTimeInterval min = 2.0;
    NSTimeInterval max = 200.0;
    NSTimeInterval multi = 20.0;
    RDSScheduler *scheduler = [RDSScheduler schedulerWithMinimumTimeBetweenSubmissionAttempts:min
                                                                   maximumTimeBetweenAttempts:max
                                                              multiplierOfTimeBetweenAttempts:multi];
    XCTAssertNotNil(scheduler);

    // WHEN
    // Post note to get submission scheduled
    NSNotification *startNote = [NSNotification notificationWithName:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                                              object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:startNote];
    
    // Post note to say has completed and failed which should cause timer to be reset
    NSNotification *stopNote = [NSNotification notificationWithName:kRDSResubmissionProcessCompleteNOTIFICATION
                                                             object:nil
                                                           userInfo:@{kRDSResubmissionResultKEY:@(NO)}];
    [[NSNotificationCenter defaultCenter]postNotification:stopNote];

    // THEN
    NSTimeInterval timeTillNext = [scheduler timeIntervalTillNextSubmissionAttempt];
    XCTAssertTrue(timeTillNext >= ((min*multi)*0.95), @"TimeTillNext: %f",timeTillNext); // multiply by 0.95 to give generous margin of error due to processing time
    
}






@end
