


#import "RDSBackendProxyBasicResponsesTestsAbstract.h"

@interface RDSLocalHostBackendProxyBasicResponsesTests : RDSBackendProxyBasicResponsesTestsAbstract

@end

@implementation RDSLocalHostBackendProxyBasicResponsesTests

- (void)setUp {
    [super setUp];
    self.backendProxyBaseURL = @"http://localhost/~leu/rds_pod_backend_proxy";
}

- (void)tearDown {
    self.backendProxyBaseURL = nil;
    [super tearDown];
}



@end
