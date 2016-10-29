//
//  NSMutableArray+KFXAdditions.m
//  Pods
//
//  Created by Leu on 09/10/2016.
//
//

#import "NSMutableArray+KFXAdditions.h"

@implementation NSMutableArray (KFXAdditions)

-(BOOL)kfx_addObject:(id)object{
    
    if (object != nil) {
        [self addObject:object];
        return YES;
    }
    return NO;
}

@end
