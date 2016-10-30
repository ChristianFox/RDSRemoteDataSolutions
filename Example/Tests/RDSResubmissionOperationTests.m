

#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSResubmissionOperation.h>
// Mocks
#import "MOCKSubmission.h"
#import "MOCKSubmitterAlwaysReportsSuccess.h"
// Constants
#import <RDSRemoteDataSolutions/RDSConstants.h>



@interface RDSResubmissionOperationTests : XCTestCase

@end

@implementation RDSResubmissionOperationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test Initilise
//--------------------------------------------------------
-(void)testResubmissionOperationConvienceInitiliser_WithNilSubmissions_ShouldReturnNil{
    
    MOCKSubmitterAlwaysReportsSuccess *submitter = [MOCKSubmitterAlwaysReportsSuccess defaultSubmitter];
    NSMutableArray <id<RDSSubmissionInterface>>*submissions = nil;
    RDSResubmissionOperation *operation = [RDSResubmissionOperation resubmissionOperationWithSubmissions:submissions
                                                                                               submitter:submitter];
    XCTAssertNil(operation);
}

-(void)testResubmissionOperationConvienceInitiliser_WithEmptySubmissionsArray_ShouldReturnNil{
    
    MOCKSubmitterAlwaysReportsSuccess *submitter = [MOCKSubmitterAlwaysReportsSuccess defaultSubmitter];
    NSMutableArray <id<RDSSubmissionInterface>>*submissions = [@[]mutableCopy];
    RDSResubmissionOperation *operation = [RDSResubmissionOperation resubmissionOperationWithSubmissions:submissions
                                                                                               submitter:submitter];
    XCTAssertNil(operation);
}

-(void)testResubmissionOperationConvienceInitiliser_WithNilSubmitter_ShouldReturnNil{
    
    MOCKSubmitterAlwaysReportsSuccess *submitter = nil;
    NSMutableArray <id<RDSSubmissionInterface>>*submissions = [@[[[MOCKSubmission alloc]init]]mutableCopy];
    RDSResubmissionOperation *operation = [RDSResubmissionOperation resubmissionOperationWithSubmissions:submissions
                                                                                               submitter:submitter];
    XCTAssertNil(operation);
}

-(void)testResubmissionOperationConvienceInitiliser_WithValidArguments_ShouldReturnResubmissionOperation{

    MOCKSubmitterAlwaysReportsSuccess *submitter = [MOCKSubmitterAlwaysReportsSuccess defaultSubmitter];
    NSMutableArray <id<RDSSubmissionInterface>>*submissions = [@[[[MOCKSubmission alloc]init]]mutableCopy];
    RDSResubmissionOperation *operation = [RDSResubmissionOperation resubmissionOperationWithSubmissions:submissions
                                                                                               submitter:submitter];
    XCTAssertNotNil(operation);
}


//--------------------------------------------------------
#pragma mark - Test Main Functionality
//--------------------------------------------------------
-(void)testOperation_SubmitsSubmissions_ShouldRemoveSubmissionsFromArray_And_PostsCompletionNotification{

    
    
    // GIVEN
    MOCKSubmitterAlwaysReportsSuccess *submitter = [MOCKSubmitterAlwaysReportsSuccess defaultSubmitter];
    MOCKSubmission *submission1 = [[MOCKSubmission alloc]init];
    MOCKSubmission *submission2 = [[MOCKSubmission alloc]init];
    MOCKSubmission *submission3 = [[MOCKSubmission alloc]init];
    NSMutableArray <id<RDSSubmissionInterface>>*submissions = [NSMutableArray arrayWithCapacity:3];
    [submissions addObject:submission1];
    [submissions addObject:submission2];
    [submissions addObject:submission3];
    RDSResubmissionOperation *operation = [RDSResubmissionOperation resubmissionOperationWithSubmissions:submissions
                                                                                               submitter:submitter];
    XCTAssertNotNil(operation);
    XCTAssertEqual(operation.submissionsCount, 3);

    // Expect
    [self expectationForNotification:kRDSResubmissionProcessCompleteNOTIFICATION
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 BOOL success = NO;
                                 success = [notification.userInfo[kRDSResubmissionResultKEY] boolValue];
                                 // THEN
                                 XCTAssertTrue(success);
                                 XCTAssertEqual(operation.submissionSuccesses, operation.submissionsCount);
                                 XCTAssertEqual(operation.submissionFailures, 0);
                                 return YES;
                             }];

    // WHEN
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
    
    
    
    
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];

    
    
}




@end











