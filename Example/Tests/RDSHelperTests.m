


#import <XCTest/XCTest.h>
// SUT
#import <RDSRemoteDataSolutions/RDSHelper.h>

@interface RDSHelperTests : XCTestCase
@property (strong,nonatomic) RDSHelper *sut;
@end

@implementation RDSHelperTests

- (void)setUp {
    [super setUp];
    self.sut = [RDSHelper helper];
    
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

//--------------------------------------------------------
#pragma mark - Test Init
//--------------------------------------------------------
-(void)testHelperConvienceInitiliser{
    XCTAssertNotNil(self.sut);
}

//--------------------------------------------------------
#pragma mark - Test WWW-Form-Encoding
//--------------------------------------------------------
-(void)testWWWFormURLEncoding_WithNilDictionary_ShouldReturnNilString{
    
    NSDictionary *params = nil;
    NSString *expected = nil;
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithDictionaryWithArrays_ShouldReturnNilString{
    
    NSDictionary *params = @{@"Array1":@[],@"Array2":@[@"string1"]};
    NSString *expected = nil;
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithOneKeyValuePairOfStrings_ShouldReturnString{
    
    NSDictionary *params = @{@"key1":@"value1"};
    NSString *expected = @"key1=value1";
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithTwoKeyValuePairsOfStrings_ShouldReturnString{
    
    NSDictionary *params = @{@"key1":@"value1",@"key2":@"value2"};
    NSString *expected = @"key1=value1&key2=value2";
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithOneKeyValuePairsOfNumbers_ShouldReturnString{
    
    NSDictionary *params = @{@11:@99};
    NSString *expected = @"11=99";
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithTwoKeyValuePairsOfNumbers_ShouldReturnString{
    
    NSDictionary *params = @{@11:@99,@666:@13};
    NSString *expected = @"666=13&11=99"; // comes out in this order
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithFourKeyValuePairsMixedStringsAndNumbers_ShouldReturnString{
    
    NSDictionary *params = @{@1:@1.1,@"key2":@2.2,@"key3":@"value3",@4:@"value4.4"};
    NSString *expected = @"key3=value3&key2=2.2&1=1.1&4=value4.4"; // comes out in this order
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithNestedKeyValuePairsMixedStringsAndNumbers_ShouldReturnString{
    
    NSDictionary *params = @{@1:@1.1,@"nested":@{@"key2":@2.2,@"key3":@"value3",@4:@"value4.4"}};
    NSString *expected = @"4=value4.4&key3=value3&key2=2.2&1=1.1"; // comes out in this order
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithTwoKeyValuePairsOfStringsThatNeedPercentEscaping_ShouldReturnString{
    
    NSDictionary *params = @{@"key 1":@"value/1",@"key={}&2":@"value$*/2"};
    NSString *expected = @"key%201=value%2F1&key%3D%7B%7D%262=value%24%2A%2F2"; // comes out in this order
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}

-(void)testWWWFormURLEncoding_WithTwoKeyValuePairsOfStringThatNeedPercentEscapingAndNumbers_ShouldReturnString{
    
    NSDictionary *params = @{@"key 1":@"value/1",@"key={}&2":@"value$*/2",@"key!@£3":@123};
    NSString *expected = @"key%201=value%2F1&key%21%40%C2%A33=123&key%3D%7B%7D%262=value%24%2A%2F2"; // comes out in this order
    NSString *received = [self.sut wwwFormURLEncodedStringFromParameters:params];
    
    XCTAssertEqualObjects(expected, received);
}


@end
