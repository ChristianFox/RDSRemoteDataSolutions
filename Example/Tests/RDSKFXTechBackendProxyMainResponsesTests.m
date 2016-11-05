
#import "RDSBackendProxyMainResponsesAbstract.h"

@interface RDSKFXTechBackendProxyMainResponsesTests : RDSBackendProxyMainResponsesAbstract

@end

@implementation RDSKFXTechBackendProxyMainResponsesTests

- (void)setUp {
    [super setUp];
    self.backendProxyBaseURL = @"http://kfxtech.com/appdata/rds_pod_backend_proxy";
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
