/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with RDSRemoteDataSolutions
 *
 ************************************/

#import "RDSHelper.h"
#import <KFXAdditions/NSString+KFXAdditions.h>

@implementation RDSHelper

+(instancetype)helper{
    RDSHelper *helper = [[self alloc]init];
    return helper;
}

-(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params{
    
    // ## Defensive
    if (params.count == 0) {
        return nil;
    }
    
    NSMutableString *mutString = [[NSMutableString alloc]init];
    
    for (NSString *key in params) {
        
        id value = params[key];
        
        NSString *keyValuePair = [self urlEncodedStringFromKey:key value:value];
        
        if (keyValuePair == nil) {
            return nil;
        }
        if (mutString.length == 0) {
            [mutString appendString:keyValuePair];
        }else{
            [mutString appendString:@"&"];
            [mutString appendString:keyValuePair];
        }
    }
    
    return [mutString copy];
}

+(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params{
    
    // ## Defensive
    if (params.count == 0) {
        return nil;
    }
    
    NSMutableString *mutString = [[NSMutableString alloc]init];
    
    for (NSString *key in params) {
        
        id value = params[key];
        
        NSString *keyValuePair = [self urlEncodedStringFromKey:key value:value];
        
        if (keyValuePair == nil) {
            return nil;
        }
        if (mutString.length == 0) {
            [mutString appendString:keyValuePair];
        }else{
            [mutString appendString:@"&"];
            [mutString appendString:keyValuePair];
        }
    }
    
    return [mutString copy];
}

+(NSString *)wwwFormURLEncodedStringFromParameters:(NSDictionary *)params withOrderedKeys:(NSArray *)orderedKeys{
    
    // ## Defensive
    if (params.count == 0) {
        return nil;
    }
    
    NSMutableString *mutString = [[NSMutableString alloc]init];
    
    for (NSString *key in orderedKeys) {
        
        id value = params[key];
        
        NSString *keyValuePair = [self urlEncodedStringFromKey:key value:value];
        
        if (keyValuePair == nil) {
            return nil;
        }
        if (mutString.length == 0) {
            [mutString appendString:keyValuePair];
        }else{
            [mutString appendString:@"&"];
            [mutString appendString:keyValuePair];
        }
    }
    
    return [mutString copy];
    
    
    
}

-(NSString*)urlEncodedStringFromKey:(NSString*)key value:(id)value DEPRECATED_ATTRIBUTE{
    
    NSString *string;
    id finalKey;
    if ([value isKindOfClass:[NSString class]]){
        // percent escape the key if needed
        if ([key isKindOfClass:[NSString class]]) {
            finalKey = [key kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
        }else{
            finalKey = key;
        }
        // percent escape the value
        string = [NSString stringWithFormat:@"%@=%@",finalKey,[value kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8]];
        
    }else if ([value isKindOfClass:[NSNumber class]]) {
        // percent escape the key if needed
        if ([key isKindOfClass:[NSString class]]) {
            finalKey = [key kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
        }else{
            finalKey = key;
        }
        string = [NSString stringWithFormat:@"%@=%@",finalKey,value];
        
    }else if ([value isKindOfClass:[NSDictionary class]]){
        // Dictionaries can be handled recursively by initial method
        string = [self wwwFormURLEncodedStringFromParameters:value];
    }
    
    return string;
    
}

+(NSString*)urlEncodedStringFromKey:(NSString*)key value:(id)value{
    
    NSString *string;
    id finalKey;
    if ([value isKindOfClass:[NSString class]]){
        // percent escape the key if needed
        if ([key isKindOfClass:[NSString class]]) {
            finalKey = [key kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
        }else{
            finalKey = key;
        }
        // percent escape the value
        string = [NSString stringWithFormat:@"%@=%@",finalKey,[value kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8]];
        
    }else if ([value isKindOfClass:[NSNumber class]]) {
        // percent escape the key if needed
        if ([key isKindOfClass:[NSString class]]) {
            finalKey = [key kfx_stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
        }else{
            finalKey = key;
        }
        string = [NSString stringWithFormat:@"%@=%@",finalKey,value];
        
    }else if ([value isKindOfClass:[NSDictionary class]]){
        // Dictionaries can be handled recursively by initial method
        string = [self wwwFormURLEncodedStringFromParameters:value];
    }
    
    return string;
    
}



+(NSDictionary *)parseQueryString:(NSString *)query{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;

}

@end
