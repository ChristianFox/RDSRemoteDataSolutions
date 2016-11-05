

#import "RDSSubmission.h"

NSString *const kRDSSubmissionDestinationURLKEY = @"destinationURL";
NSString *const kRDSSubmissionParametersKEY = @"parameters";
NSString *const kRDSSubmissionContentTypeKEY = @"contentType";
NSString *const kRDSSubmissionHTTPMethodKEY = @"httpMethod";


@implementation RDSSubmission


+(instancetype)submission{
    return [[self alloc]init];
}

//======================================================
#pragma mark - ** Protocol Methods **
//======================================================

//--------------------------------------------------------
#pragma mark - NSCoding
//--------------------------------------------------------
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self) {
        self.destinationURL = [coder decodeObjectForKey:kRDSSubmissionDestinationURLKEY];
        self.parameters = [coder decodeObjectForKey:kRDSSubmissionParametersKEY];
        self.HTTPMethod = [coder decodeObjectForKey:kRDSSubmissionHTTPMethodKEY];
        self.submissionContentType = [coder decodeIntegerForKey:kRDSSubmissionContentTypeKEY];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //    [super encodeWithCoder:coder];
    [coder encodeObject:self.destinationURL forKey:kRDSSubmissionDestinationURLKEY];
    [coder encodeObject:self.parameters forKey:kRDSSubmissionParametersKEY];
    [coder encodeObject:self.HTTPMethod forKey:kRDSSubmissionHTTPMethodKEY];
    [coder encodeInteger:self.submissionContentType forKey:kRDSSubmissionContentTypeKEY];
    
}

@end
