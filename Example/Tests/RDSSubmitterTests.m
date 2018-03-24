


#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSSubmitter.h>
// Other
#import <RDSRemoteDataSolutions/RDSNetworkConnector.h>
#import <RDSRemoteDataSolutions/RDSDefinitions.h>
// Mocks
#import "MOCKSubmission.h"
#import "MOCKNetworkConnector.h"

@interface RDSSubmitterTests : XCTestCase

@end

@implementation RDSSubmitterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test Init
//--------------------------------------------------------
-(void)testDefaultSubmitterConvienceInitiliser{
    
    RDSSubmitter *submitter = [RDSSubmitter defaultSubmitter];
    XCTAssertNotNil(submitter);
    XCTAssertNotNil(submitter.networkConnector);
    XCTAssertTrue([submitter.networkConnector isKindOfClass:[RDSNetworkConnector class]]);
}

-(void)testSubmitterWithNetworkConnectorConvienceInitiliser{
    
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    RDSSubmitter *submitter = [RDSSubmitter submitterWithNetworkConnector:connector];
    XCTAssertNotNil(submitter);
    XCTAssertNotNil(submitter.networkConnector);
    XCTAssertEqualObjects(submitter.networkConnector, connector);
}


//--------------------------------------------------------
#pragma mark - Test Submissions that are invalid
//--------------------------------------------------------
-(void)testSubmitSubmission_WithSubmissionThatHasNilParameters_ShouldCompleteWithSubmissionParametersIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    RDSSubmitter *submitter = [RDSSubmitter defaultSubmitter];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"http://www.google.com"];
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.parameters = nil;
    
    // WHEN
    [submitter submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNotNil(error);
                     XCTAssertEqual(error.code, RDSErrorSubmissionParametersIsNil);
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
#pragma mark - Test Submissions that are valid
//--------------------------------------------------------
-(void)testSubmitSubmission_WithValidSubmissionForBasicURLDataTask_ShouldCompleteWithData{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKNetworkConnector *connector = [MOCKNetworkConnector networkConnector];
    RDSSubmitter *submitter = [RDSSubmitter submitterWithNetworkConnector:connector];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"https://www.mockaroundtheclock.com/"];
    submission.submissionContentType = RDSSubmissionContentTypeNone;
    submission.parameters = nil;
    
    // WHEN
    [submitter submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNil(error);
                     XCTAssertNotNil(data);
                     XCTAssertNotNil(response);
                     
                     if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                         XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                     }
                     
                     if (data != nil) {
                         NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                         XCTAssertEqualObjects(dataString, [[submission destinationURL] absoluteString]);
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


-(void)testSubmitSubmission_WithValidSubmissionForJSONDataTask_ShouldCompleteWithData{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKNetworkConnector *connector = [MOCKNetworkConnector networkConnector];
    RDSSubmitter *submitter = [RDSSubmitter submitterWithNetworkConnector:connector];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"https://www.mockaroundtheclock.com/"];
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.parameters = @{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]};
    submission.HTTPMethod = @"POST";
    
    // WHEN
    [submitter submitSubmission:submission
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


-(void)testSubmitSubmission_WithValidSubmissionForURLEncodedDataTask_ShouldCompleteWithData{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    MOCKNetworkConnector *connector = [MOCKNetworkConnector networkConnector];
    RDSSubmitter *submitter = [RDSSubmitter submitterWithNetworkConnector:connector];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:@"https://www.mockaroundtheclock.com/"];
    submission.submissionContentType = RDSSubmissionContentTypeWWWURLEncodedString;
    submission.parameters = @{@"key1":@"value1",@"key2":@"value2",@"key3":@3};
    submission.HTTPMethod = @"POST";
    
    // WHEN
    [submitter submitSubmission:submission
                 withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     // THEN
                     XCTAssertNil(error);
                     XCTAssertNotNil(data);
                     XCTAssertNotNil(response);
                     
                     if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                         XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                     }
                     
                     if (data != nil) {
                         NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                         XCTAssertTrue([dataString containsString:submission.parameters[@"key1"]]);
                         XCTAssertTrue([dataString containsString:submission.parameters[@"key2"]]);
                         XCTAssertTrue([dataString containsString:@"3"]);
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
















@end

















