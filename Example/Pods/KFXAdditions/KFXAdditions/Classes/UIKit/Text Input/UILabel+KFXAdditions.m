/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXAdditions
 *
 ************************************/

#import "UILabel+KFXAdditions.h"

@implementation UILabel (KFXAdditions)

-(BOOL)kfx_setText:(NSString*)text withDefault:(NSString*)defaultText{

    if (text == nil || [text isEqual:[NSNull null]] || text.length == 0) {
        self.text = defaultText;
        return NO;
    }else{
        self.text = text;
        return YES;
    }
}

-(BOOL)kfx_setTextToNumber:(NSNumber *)number withDefault:(NSString *)defaultText{
    
    if (number == nil || [number isEqual:[NSNull null]]) {
        self.text = defaultText;
        return NO;
    }else{
        self.text = [number stringValue];
        return YES;
    }
    
}

-(BOOL)kfx_setAttributedText:(NSAttributedString *)text withDefault:(NSAttributedString *)defaultText{
    
    if (text == nil || [text isEqual:[NSNull null]] || text.string.length == 0) {
        self.attributedText = defaultText;
        return NO;
    }else{
        self.attributedText = text;
        return YES;
    }

}

@end
