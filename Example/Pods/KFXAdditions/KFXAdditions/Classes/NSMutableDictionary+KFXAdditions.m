


#import "NSMutableDictionary+KFXAdditions.h"

@implementation NSMutableDictionary (KFXAdditions)


-(BOOL)kfx_setObject:(id __nullable)object forKey:(id<NSCopying> __nullable)key{
    
    if (object != nil && key != nil) {
        [self setObject:object forKey:key];
        return YES;
    }
    return NO;
}

@end
