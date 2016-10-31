

#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSValidator.h>

@interface RDSValidatorTests : XCTestCase

@end

@implementation RDSValidatorTests

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
-(void)testInit{
    RDSValidator *validator = [[RDSValidator alloc]init];
    XCTAssertNotNil(validator);
}

-(void)testValidatorConvinienceMethod{
    RDSValidator *validator = [RDSValidator validator];
    XCTAssertNotNil(validator);
}








@end
