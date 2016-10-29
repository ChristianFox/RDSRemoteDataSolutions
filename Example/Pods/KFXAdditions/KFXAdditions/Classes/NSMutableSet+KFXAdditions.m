


#import "NSMutableSet+KFXAdditions.h"

@implementation NSMutableSet (KFXAdditions)


-(BOOL)kfx_addObject:(id)object{
    
    if (object != nil) {
        [self addObject:object];
        return YES;
    }
    return NO;
}

@end
