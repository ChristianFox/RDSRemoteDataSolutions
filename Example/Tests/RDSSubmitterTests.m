//
//  RDSSubmitterTests.m
//  RDSRemoteDataSolutions
//
//  Created by Leu on 29/10/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSSubmitter.h>
// Other
#import <RDSRemoteDataSolutions/RDSNetworkConnector.h>
#import <RDSRemoteDataSolutions/RDSDefinitions.h>
// Mocks
#import "MOCKSubmission.h"

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
#pragma mark - Test Submission
//--------------------------------------------------------
-(void)testSubmitSubmission_WithNilSubmission_ShouldCompleteWithSubmissionIsNilError{
    
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with error"];
    
    // GIVEN
    RDSSubmitter *submitter = [RDSSubmitter defaultSubmitter];
    MOCKSubmission *submission = nil;
    
    // WHEN
    [submitter submitSubmission:submission
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
    RDSSubmitter *submitter = [RDSSubmitter defaultSubmitter];
    MOCKSubmission *submission = [[MOCKSubmission alloc]init];
    submission.destinationURL = nil;
    
    // WHEN
    [submitter submitSubmission:submission
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



@end
