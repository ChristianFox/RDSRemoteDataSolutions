

#import "RDSBackendProxyBasicResponsesTestsAbstract.h"
// SUT
#import <RDSRemoteDataSolutions/RDSSubmissionStation.h>
// Mocks
#import "MOCKLocalHostSubmission.h"


@interface RDSBackendProxyBasicResponsesTestsAbstract()
@end

@implementation RDSBackendProxyBasicResponsesTestsAbstract

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test can submit to backend & it echos a string
//--------------------------------------------------------
-(void)testSubmitSubmission_WithNoContent_POST_ShouldReceiveString{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_string.php"]];
    submission.submissionContentType = RDSSubmissionContentTypeNone;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string isEqualToString:@"RDSBackendProxy received submission"]);
                   [expectation fulfill];
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testSubmitSubmission_WithNoContent_GET_ShouldReceiveString{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_string.php"]];
    submission.submissionContentType = RDSSubmissionContentTypeNone;
    submission.HTTPMethod = @"GET";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string isEqualToString:@"RDSBackendProxy received submission"]);
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
#pragma mark - Test can submit to backend & it echos $_POST
//--------------------------------------------------------
-(void)testSubmitSubmission_WithURLEncodedString_POST_ShouldReceiveJSON{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with json object returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_post.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeWWWURLEncodedString;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions error:nil];
                   XCTAssertNotNil(json);
                   XCTAssertEqualObjects(json, submission.parameters);
                   
                   [expectation fulfill];
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testSubmitSubmission_WithJSON_POST_ShouldReceiveJSON{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with json object returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_post.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions error:nil];
                   XCTAssertNotNil(json);
                   XCTAssertEqualObjects(json, submission.parameters,@"json is : %@",json);
                   
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
#pragma mark - Test can submit to backend & it echos request headers
//--------------------------------------------------------
-(void)testSubmitSubmission_WithJSON_POST_ShouldReceiveRequestHeaders{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with json object returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_request_headers.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string containsString:@"Host: localhost"] || [string containsString:@"Host: kfxtech.com"]);
                   XCTAssertTrue([string containsString:@"Accept: application/json"]);
                   XCTAssertTrue([string containsString:@"User-Agent: RDSRemoteDataSolutions_Example"]);
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
#pragma mark - Test can submit to backend & it echos $_REQUEST
//--------------------------------------------------------
-(void)testSubmitSubmission_WithJSON_POST_ShouldReceiveRequest{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with json object returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_request.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   [expectation fulfill];
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testSubmitSubmission_WithWWWURLEncodedString_POST_ShouldReceiveRequest{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with json object returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_request.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeWWWURLEncodedString;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
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
#pragma mark - Test can submit to backend & it echos $_SERVER
//--------------------------------------------------------
-(void)testSubmitSubmission_WithNoContent_GET_ShouldReceiveServerData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_server.php"]];
    submission.submissionContentType = RDSSubmissionContentTypeNone;
    submission.HTTPMethod = @"GET";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string containsString:@"HTTP_HOST\":\"localhost"] || [string containsString:@"HTTP_HOST\":\"kfxtech.com"]);
                   XCTAssertTrue([string containsString:@"REQUEST_METHOD\":\"GET"]);
                   XCTAssertTrue([string containsString:@"HTTP_USER_AGENT\":\"RDSRemoteDataSolutions_Example"]);
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions error:nil];
                   XCTAssertNotNil(json);

                   [expectation fulfill];
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testSubmitSubmission_WithURLEncodedString_POST_ShouldReceiveServerData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_server.php"]];
    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeWWWURLEncodedString;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string containsString:@"HTTP_HOST\":\"localhost"] || [string containsString:@"HTTP_HOST\":\"kfxtech.com"]);
                   XCTAssertTrue([string containsString:@"REQUEST_METHOD\":\"POST"]);
                   XCTAssertTrue([string containsString:@"HTTP_USER_AGENT\":\"RDSRemoteDataSolutions_Example"]);
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions error:nil];
                   XCTAssertNotNil(json);
                   
                   [expectation fulfill];
               }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testSubmitSubmission_WithJSON_POST_ShouldReceiveServerData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKLocalHostSubmission *submission = [[MOCKLocalHostSubmission alloc]init];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/basic_unit_test_responses/rds_echo_server.php"]];

    submission.parameters = @{@"key1":@"value1"};
    submission.submissionContentType = RDSSubmissionContentTypeJSONData;
    submission.HTTPMethod = @"POST";
    submission.shouldScheduleForResubmissionOnFailure = NO;
    
    // WHEN
    RDSSubmissionStation *station = [RDSSubmissionStation defaultSubmissionStation];
    [station submitSubmission:submission
               withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                   
                   // THEN
                   XCTAssertNil(error);
                   XCTAssertNotNil(data);
                   
                   NSString *string = [[NSString alloc]initWithData:data
                                                           encoding:NSUTF8StringEncoding];
                   XCTAssertNotNil(string);
                   XCTAssertTrue([string containsString:@"HTTP_HOST\":\"localhost"] || [string containsString:@"HTTP_HOST\":\"kfxtech.com"]);
                   XCTAssertTrue([string containsString:@"REQUEST_METHOD\":\"POST"]);
                   XCTAssertTrue([string containsString:@"HTTP_USER_AGENT\":\"RDSRemoteDataSolutions_Example"]);
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:kNilOptions error:nil];
                   XCTAssertNotNil(json);
                   
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






















