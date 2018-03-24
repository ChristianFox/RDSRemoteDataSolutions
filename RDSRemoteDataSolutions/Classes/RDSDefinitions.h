/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/



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
    RDSErrorSubmissionDoesNotConformToNSCoding,
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
