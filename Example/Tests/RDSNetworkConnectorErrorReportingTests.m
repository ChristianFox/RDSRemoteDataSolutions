

#import <XCTest/XCTest.h>
#import <RDSRemoteDataSolutions/RDSNetworkConnector.h>

@interface RDSNetworkConnectorErrorReportingTests : XCTestCase

@end

@implementation RDSNetworkConnectorErrorReportingTests

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
-(void)testNetworkConnectorConvinenceInitiliser{
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    XCTAssertNotNil(connector);
}

//--------------------------------------------------------
#pragma mark - Test Submitting to URL catches invalid arguments
//--------------------------------------------------------
-(void)testDataTaskWithURL_WithNilURL_ShouldCompleteWithURLIsNilError{
    
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = nil;
    
    // WHEN
    [connector dataTaskWithURL:url
                    completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        
                        // THEN
                        XCTAssertNotNil(error);
                        XCTAssertEqual(error.code, RDSErrorURLIsNil);
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
#pragma mark - Test Submitting JSON Data catches invalid arguments
//--------------------------------------------------------
-(void)testDataTaskWithJSONData_WithNilURL_ShouldCompleteWithURLIsNilError{
    
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:@[@"one",@"two"]
                                                   options:kNilOptions
                                                     error:nil];
    
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"POST"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNotNil(error);
                             XCTAssertEqual(error.code, RDSErrorURLIsNil);
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

-(void)testDataTaskWithJSONData_WithNilJSONData_ShouldCompleteWithJSONDataIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSData *data = nil;
    
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"POST"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNotNil(error);
                             XCTAssertEqual(error.code, RDSErrorJSONDataIsNil);
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


-(void)testDataTaskWithJSONData_WithZeroLengthJSONData_ShouldCompleteWithJSONDataLengthIsZeroError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSData *data = [NSData dataWithBytes:nil length:0];
    
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"POST"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNotNil(error);
                             XCTAssertEqual(error.code, RDSErrorJSONDataLengthIsZero);
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
#pragma mark - Test Submitting URLEncodedString catches invalid arguments
//--------------------------------------------------------
-(void)testDataTaskWithURLEncodedString_WithNilURL_ShouldCompleteWithURLIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = nil;
    NSString *encodedString = @"key1=value1&key2=value2";
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"POST"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
                                     // THEN
                                     XCTAssertNotNil(error);
                                     XCTAssertEqual(error.code, RDSErrorURLIsNil);
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

-(void)testDataTaskWithURLEncodedString_WithNilEncodedString_ShouldCompleteWithEncodedStringIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSString *encodedString = nil;
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"POST"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
                                     // THEN
                                     XCTAssertNotNil(error);
                                     XCTAssertEqual(error.code, RDSErrorURLEncodedStringIsNil);
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

-(void)testDataTaskWithURLEncodedString_WithZeroLengthEncodedString_ShouldCompleteWithEncodedStringIsNilError{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSString *encodedString = @"";
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"POST"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
                                     // THEN
                                     XCTAssertNotNil(error);
                                     XCTAssertEqual(error.code, RDSErrorURLEncodedStringLengthIsZero);
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









@end
