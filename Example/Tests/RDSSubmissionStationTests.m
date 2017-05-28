

#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSSubmissionStation.h>
// Mocks
#import "MOCKNetworkConnector.h"
#import "MOCKNetworkConnectorWithFailingNetwork.h"
#import "MOCKSubmission.h"
// Constants
#import <RDSRemoteDataSolutions/RDSConstants.h>

@interface RDSSubmissionStationTests : XCTestCase
@property (strong,nonatomic) RDSSubmissionStation *sut;
@end

@implementation RDSSubmissionStationTests

- (void)setUp {
    [super setUp];
    MOCKNetworkConnector *connector = [MOCKNetworkConnector networkConnector];
    RDSSubmissionStation *station = [RDSSubmissionStation submissionStationWithNetworkConnector:connector];
    self.sut = station;
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test Init
//--------------------------------------------------------
-(void)testDefaultSubmissionStationConvienceInitiliser{
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    XCTAssertNotNil(station);
}

-(void)testSubmissionStationWithNilNetworkConnectorConvienceInitiliser_ShouldReturnNil{
    MOCKNetworkConnector *connector = nil;
    RDSSubmissionStation *station = [RDSSubmissionStation submissionStationWithNetworkConnector:connector];
    XCTAssertNil(station);
}

-(void)testSubmissionStationWithValidNetworkConnectorConvienceInitiliser_ShouldReturnSubmissionStation{
    MOCKNetworkConnector *connector = [MOCKNetworkConnector networkConnector];
    RDSSubmissionStation *station = [RDSSubmissionStation submissionStationWithNetworkConnector:connector];
    XCTAssertNotNil(station);
}

-(void)testSUTIsInitilised{
    XCTAssertNotNil(self.sut);
}


//--------------------------------------------------------
#pragma mark - Test Submissions that are invalid
//--------------------------------------------------------
-(void)testSubmitSubmission_WithNilSubmission_ShouldCompleteWithSubmissionIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKSubmission *submission = nil;
    
    // WHEN
    [self.sut submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNotNil(error);
                     XCTAssertEqual(error.code, RDSErrorSubmissionIsNil);
                     XCTAssertNil(data);
                     XCTAssertNil(response);
                     [expectation fulfill];
                 }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testSubmitSubmission_WithSubmissionThatHasNilURL_ShouldCompleteWithSubmissionURLIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = nil;
    
    // WHEN
    [self.sut submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNotNil(error);
                     XCTAssertEqual(error.code, RDSErrorSubmissionURLIsNil);
                     XCTAssertNil(data);
                     XCTAssertNil(response);
                     [expectation fulfill];
                 }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testSubmitSubmission_WithSubmissionThatHasUndefinedContentType_ShouldCompleteWithSubmissionContentTypeIsUndefinedError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"http://www.google.com"];
    submission.submissionContentType = RDSSubmissionContentTypeUndefined;
    
    // WHEN
    [self.sut submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNotNil(error);
                     XCTAssertEqual(error.code, RDSErrorSubmissionContentTypeIsUndefined);
                     XCTAssertNil(data);
                     XCTAssertNil(response);
                     [expectation fulfill];
                 }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


//--------------------------------------------------------
#pragma mark - Test successful submission with valid submission
//--------------------------------------------------------
-(void)testSubmitSubmission_WithValidSubmission_ShouldCompleteSuccessfullyWithData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"https://www.mockaroundtheclock.com/"];
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.parameters = @{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]};
    submission.HTTPMethod = @"POST";

    
    // WHEN
    [self.sut submitSubmission:submission
                withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                    // THEN
                    XCTAssertNil(error);
                    XCTAssertNotNil(data);
                    XCTAssertNotNil(response);
                    
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                    }
                    
                    if (data != nil) {
                        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:nil];
                        XCTAssertNotNil(responseDict);
                        XCTAssertEqualObjects(responseDict, [submission parameters]);
                    }
                    
                    [expectation fulfill];
                }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


//--------------------------------------------------------
#pragma mark - Test Submission failure due to network issue
//--------------------------------------------------------
-(void)testSubmitSubmission_WithValidSubmissionAndNetworkFailure_ShouldReturnErrorAndPostNotificationThatSubmissionHasBeenStored{
    
    // Expect
    [self expectationForNotification:kRDSSubmissionStoredForResubmissionNOTIFICATION
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                
                                 // THEN
                                 return YES;
                             }];
    
    
    // GIVEN
    MOCKNetworkConnectorWithFailingNetwork *connector = [MOCKNetworkConnectorWithFailingNetwork networkConnector];
    RDSSubmissionStation *station = [RDSSubmissionStation submissionStationWithNetworkConnector:connector];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"https://www.mockaroundtheclock.com/"];
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.parameters = @{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]};
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = YES;
    
    // WHEN
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                  
                   XCTAssertNil(data);
                   XCTAssertNotNil(error);
                   XCTAssertEqual(error.code, 1234);
                   
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];

    
    
}
















@end
