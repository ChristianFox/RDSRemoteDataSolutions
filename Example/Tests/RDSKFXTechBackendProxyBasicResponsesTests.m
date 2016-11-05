//
//  RDSKFXTechBackendProxyBasicResponsesTests.m
//  RDSRemoteDataSolutions
//
//  Created by Leu on 05/11/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import "RDSBackendProxyBasicResponsesTestsAbstract.h"

@interface RDSKFXTechBackendProxyBasicResponsesTests : RDSBackendProxyBasicResponsesTestsAbstract

@end

@implementation RDSKFXTechBackendProxyBasicResponsesTests

- (void)setUp {
    [super setUp];
    self.backendProxyBaseURL = @"http://kfxtech.com/appdata/rds_pod_backend_proxy";
}

- (void)tearDown {
    self.backendProxyBaseURL = nil;
    [super tearDown];
}



@end
