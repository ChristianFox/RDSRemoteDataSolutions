

#import "RDSBackendProxyMainResponsesAbstract.h"
// SUT
#import <RDSRemoteDataSolutions/RDSSubmissionStation.h>
// Mocks
#import "MOCKSubmission.h"

@interface RDSBackendProxyMainResponsesAbstract()

@end

@implementation RDSBackendProxyMainResponsesAbstract

- (void)setUp {
    [super setUp];

}

- (void)tearDown {

    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test ContentTypeNone
//--------------------------------------------------------
-(void)rds_testSubmitSubmission_WithContentTypeNone_ShouldReceiveString{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with string returned"];
    
    // GIVEN
    MOCKSubmission *submission = [MOCKSubmission submission];
    submission.destinationURL = [NSURL URLWithString:[self.backendProxyBaseURL stringByAppendingString:@"/rds_main.php"]];
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
                   XCTAssertTrue([string hasPrefix:@"HTTPMethod is GET"],@"Received: %@",string);
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
