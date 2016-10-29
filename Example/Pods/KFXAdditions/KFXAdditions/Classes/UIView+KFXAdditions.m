


#import "UIView+KFXAdditions.h"

@implementation UIView (KFXAdditions)

-(UIView *)kfx_findFirstResponder{
    
    // Found it first time - yay!
    if ([self isFirstResponder]) {
        return self;
    }
    
    // Look through subviews
    for (UIView *subview in [self subviews]) {
        UIView *firstResponder = [subview kfx_findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    // Cannot be found
    return nil;
}

@end
