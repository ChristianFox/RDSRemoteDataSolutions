


#import <XCTest/XCTest.h>

@interface RDSBackendProxyMainResponsesAbstract : XCTestCase
@property (strong,nonatomic) NSString *backendProxyBaseURL;

-(void)rds_testSubmitSubmission_WithContentTypeNone_ShouldReceiveString;

@end
