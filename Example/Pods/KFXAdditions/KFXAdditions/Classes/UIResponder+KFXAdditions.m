


#import "UIResponder+KFXAdditions.h"
static __weak id currentFirstResponder;

@implementation UIResponder (KFXAdditions)

+(id)kfx_currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(kfx_findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

-(void)kfx_findFirstResponder:(id)sender {
    currentFirstResponder = self;
}


@end
