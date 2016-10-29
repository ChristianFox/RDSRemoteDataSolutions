//
//  RDSDefinitions.h
//  Pods
//
//  Created by Leu on 29/10/2016.
//
//

#ifndef RDSDefinitions_h
#define RDSDefinitions_h

//--------------------------------------------------------
#pragma mark - Blocks
//--------------------------------------------------------
typedef void(^RDSNetworkResponseCompletionBlock)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);


//--------------------------------------------------------
#pragma mark - Enums
//--------------------------------------------------------
typedef NS_ENUM(NSInteger, RDSError) {
    RDSErrorUnknown,
    RDSErrorSubmissionIsNil,
    RDSErrorSubmissionURLIsNil,
    RDSErrorSubmissionContentTypeIsUndefined,
    RDSErrorSubmissionParametersIsNil,
    RDSErrorJSONDataIsNil,
    RDSErrorJSONDataLengthIsZero,
    RDSErrorURLEncodedStringIsNil,
    RDSErrorURLEncodedStringLengthIsZero,
    RDSErrorURLIsNil,
    
};

typedef NS_ENUM(NSInteger, RDSSubmissionContentType) {
    RDSSubmissionContentTypeUndefined,
    RDSSubmissionContentTypeNone,
    RDSSubmissionContentTypeJSONData,
    RDSSubmissionContentTypeWWWURLEncodedString
};


#endif /* RDSDefinitions_h */
