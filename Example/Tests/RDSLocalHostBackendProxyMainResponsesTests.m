

#import "RDSBackendProxyMainResponsesAbstract.h"

@interface RDSLocalHostBackendProxyMainResponsesTests : RDSBackendProxyMainResponsesAbstract

@end

@implementation RDSLocalHostBackendProxyMainResponsesTests

- (void)setUp {
    [super setUp];
    self.backendProxyBaseURL = @"http://localhost/~leu/rds_pod_backend_proxy";
}

- (void)tearDown {
    self.backendProxyBaseURL = nil;
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test ContentTypeNone
//--------------------------------------------------------

-(void)testSubmitSubmission_WithContentTypeNone_ShouldReceiveString{

    [self rds_testSubmitSubmission_WithContentTypeNone_ShouldReceiveString];
}

@end
