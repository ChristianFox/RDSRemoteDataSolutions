

#import <XCTest/XCTest.h>
#import <RDSRemoteDataSolutions/RDSNetworkConnector.h>

@interface RDSNetworkConnectorLiveTests : XCTestCase

@end

@implementation RDSNetworkConnectorLiveTests

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
#pragma mark - Test Submitting to www.example.com retrieves some data
//--------------------------------------------------------
-(void)testDataTaskWithURL_WithURLForExampleDotCom_ShouldCompleteWithDataContainingHTML{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"https://www.example.com"];
    
    // WHEN
    [connector dataTaskWithURL:url
                    completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        
                        // THEN
                        XCTAssertNil(error);
                        XCTAssertNotNil(data);
                        XCTAssertNotNil(response);
                        
                        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                            XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                        }
                        
                        if (data != nil) {
                            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                            XCTAssertTrue([string containsString:@"<!doctype html>"]);
                        }
                        
                        [expectation fulfill];
                    }];
    
    // Wait
    [self waitForExpectationsWithTimeout:10.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


//--------------------------------------------------------
#pragma mark - Test submitting
//--------------------------------------------------------
-(void)testDataTaskWithURL_WithValidURLJsonTestDotCom_ShouldCompleteWithDataContainingHeaders{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with..."];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://headers.jsontest.com/"];
    
    // WHEN
    [connector dataTaskWithURL:url
                    completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        
                        // THEN
                        XCTAssertNil(error);
                        XCTAssertNotNil(data);
                        XCTAssertNotNil(response);
                        
                        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                            XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                        }
                        
                        if (data != nil) {
                            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:nil];
                            XCTAssertNotNil(jsonDict);
                            XCTAssertNotNil(jsonDict[@"Host"]);
                            XCTAssertNotNil(jsonDict[@"User-Agent"]);
                            
                        }
                        
                        [expectation fulfill];
                    }];
    
    // Wait
    [self waitForExpectationsWithTimeout:10.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testDataTaskWithJSONData_WithValidArgumentsToJsonTestDotCom_ShouldCompleteWithDataContainingHeaders{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://headers.jsontest.com/"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]}
                                                   options:kNilOptions
                                                     error:nil];
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"POST"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNil(error,@"### ERROR ### %@",error.localizedDescription);
                             XCTAssertNotNil(data);
                             XCTAssertNotNil(response);
                             
                             if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                 XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                             }
                             
                             if (data != nil) {
                                 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:kNilOptions
                                                                                            error:nil];
                                 XCTAssertNotNil(jsonDict);
                                 XCTAssertNotNil(jsonDict[@"Host"]);
                                 XCTAssertNotNil(jsonDict[@"Content-Type"]);
                                 XCTAssertEqualObjects(jsonDict[@"Content-Type"],@"application/json");
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


-(void)testDataTaskWithURLEncodedString_WithValidArgumentsToJsonTestDotCom_ShouldCompleteWithDataContainingHeaders{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://headers.jsontest.com/"];
    NSString *encodedString = @"key1=value1&key2=value2";
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"POST"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
                                     // THEN
                                     XCTAssertNil(error);
                                     XCTAssertNotNil(data);
                                     XCTAssertNotNil(response);
                                     
                                     if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                         XCTAssertEqual(200, [(NSHTTPURLResponse*)response statusCode]);
                                     }
                                     
                                     if (data != nil) {
                                         NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                  options:kNilOptions
                                                                                                    error:nil];
                                         XCTAssertNotNil(jsonDict);
                                         XCTAssertNotNil(jsonDict[@"Host"]);
                                         XCTAssertNotNil(jsonDict[@"Content-Type"]);
                                         XCTAssertEqualObjects(@"application/x-www-form-urlencoded",jsonDict[@"Content-Type"]);
                                         
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
#pragma mark - Test post to Httpbin.org
//--------------------------------------------------------
-(void)testDataTaskWithJSONData_WithValidArgumentsToHTTPBinDotOrg_ShouldCompleteWithDataContainingPostData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSDictionary *dict = @{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:kNilOptions
                                                     error:nil];
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"POST"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNil(error,@"### ERROR ### %@",error.localizedDescription);
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
                                 XCTAssertEqualObjects(responseDict[@"json"], dict);
                                 XCTAssertEqualObjects(responseDict[@"headers"][@"Content-Type"],@"application/json");
                                 
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

-(void)testDataTaskWithURLEncodedString_WithValidArgumentsToHTTPBinDotOrg_ShouldCompleteWithDataContainingPostData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSString *encodedString = @"key1=value1&key2=value2";
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"POST"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
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
                                         XCTAssertNotNil(responseDict[@"headers"]);
                                         XCTAssertNotNil(responseDict[@"form"]);
                                         XCTAssertEqualObjects(responseDict[@"form"][@"key1"], @"value1");
                                         XCTAssertEqualObjects(responseDict[@"form"][@"key2"], @"value2");
                                         XCTAssertEqualObjects(@"application/x-www-form-urlencoded",responseDict[@"headers"][@"Content-Type"]);
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
#pragma mark - Test Put to httpbin.org
//--------------------------------------------------------
-(void)testDataTaskWithJSONDataAndPUTMethod_WithValidArgumentsToHTTPBinDotOrg_ShouldCompleteWithDataContainingPostData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/put"];
    NSDictionary *dict = @{@"words":@[@"one",@"two"],@"numbers":@[@1,@2,@3]};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:kNilOptions
                                                     error:nil];
    // WHEN
    [connector dataTaskWithJSONData:data
                                URL:url
                         HTTPMethod:@"PUT"
                         completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             // THEN
                             XCTAssertNil(error,@"### ERROR ### %@",error.localizedDescription);
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
                                 XCTAssertEqualObjects(responseDict[@"json"], dict);
                                 XCTAssertEqualObjects(responseDict[@"headers"][@"Content-Type"],@"application/json");
                                 
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

-(void)testDataTaskWithURLEncodedStringAndPUTMethod_WithValidArgumentsToHTTPBinDotOrg_ShouldCompleteWithDataContainingPostData{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with data and 200 response code"];
    
    // GIVEN
    RDSNetworkConnector *connector = [RDSNetworkConnector networkConnector];
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/put"];
    NSString *encodedString = @"key1=value1&key2=value2";
    
    // WHEN
    [connector dataTaskWithURLEncodedString:encodedString
                                        URL:url
                                 HTTPMethod:@"PUT"
                                 completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
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
                                         XCTAssertNotNil(responseDict[@"headers"]);
                                         XCTAssertNotNil(responseDict[@"form"]);
                                         XCTAssertEqualObjects(responseDict[@"form"][@"key1"], @"value1");
                                         XCTAssertEqualObjects(responseDict[@"form"][@"key2"], @"value2");
                                         XCTAssertEqualObjects(@"application/x-www-form-urlencoded",responseDict[@"headers"][@"Content-Type"]);
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
























