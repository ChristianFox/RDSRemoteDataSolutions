

#import "UIColor+KFXAdditions.h"

@implementation UIColor (KFXAdditions)


//--------------------------------------------------------
#pragma mark - Hex Colours
//--------------------------------------------------------
+ (UIColor *)kfx_colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

//--------------------------------------------------------
#pragma mark - Random Colours
//--------------------------------------------------------
+(UIColor*)kfx_randomColour{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 );
    CGFloat brightness = ( arc4random() % 128 / 256.0 );
    CGFloat alpha = ( arc4random() % 128 / 256.0 );
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    return color;
}

+(UIColor*)kfx_randomColourWithAlpha:(CGFloat)alpha{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 );
    CGFloat brightness = ( arc4random() % 128 / 256.0 );
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    return color;
}

+(UIColor*)kfx_randomColourAvoidingBlackAndWhiteWithAlpha:(CGFloat)alpha{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    CGFloat finalAlpha;
    if (alpha < 0.0) {
        finalAlpha = ( arc4random() % 128 / 256.0 );
    }else{
        finalAlpha = alpha;
    }
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:finalAlpha];
    return color;
}


//--------------------------------------------------------
#pragma mark - Alter Colours
//--------------------------------------------------------
-(UIColor *)kfx_colourByAlteringHueByAmount:(CGFloat)amount{
    
    return [self kfx_colourByAlteringHue:amount
                              saturation:0.0
                              brightness:0.0
                                   alpha:0.0];
}

-(UIColor *)kfx_colourByAlteringSaturationByAmount:(CGFloat)amount{
    
    return [self kfx_colourByAlteringHue:0.0
                              saturation:amount
                              brightness:0.0
                                   alpha:0.0];
    
}

-(UIColor *)kfx_colourByAlteringBrightnessByAmount:(CGFloat)amount{
    
    return [self kfx_colourByAlteringHue:0.0
                              saturation:0.0
                              brightness:amount
                                   alpha:0.0];

}

-(UIColor *)kfx_colourByAlteringAlphaByAmount:(CGFloat)amount{
    
    return [self kfx_colourByAlteringHue:0.0
                              saturation:0.0
                              brightness:0.0
                                   alpha:amount];

}

-(UIColor*_Nullable)kfx_colourByAlteringHue:(CGFloat)hueAlterAmount
                                 saturation:(CGFloat)saturationAlterAmount
                                 brightness:(CGFloat)brightnessAlterAmount
                                      alpha:(CGFloat)alphaAlterAmount{
    
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    BOOL isValid = [self getHue:&hue
                     saturation:&saturation
                     brightness:&brightness
                          alpha:&alpha];
    if (!isValid) {
        return nil;
    }else{
        
        /*
         For some reason I was having an issue setting the component values to 0.0 or 1.0 exactly which resulted in a UIColor object with incorrect values... possibly due to a floating point rounding error 
         Whatever the reason using slightly off values gets rid of it and should result in an inperceptable colour difference.
         */
        CGFloat newHue = hue + hueAlterAmount;
        if (newHue > 1.000) {
            newHue = 0.9999999;
        }else if (newHue < 0.000){
            newHue = 0.0000001;
        }
        CGFloat newSaturation = saturation + saturationAlterAmount;
        if (newSaturation < 0.000) {
            newSaturation = 0.0000001;
        }
        CGFloat newBrightness = brightness + brightnessAlterAmount;
        if (newBrightness < 0.0000) {
            newBrightness = 0.0000001;
        }
        CGFloat newAlpha = alpha + alphaAlterAmount;
        UIColor *newColour = [UIColor colorWithHue:newHue
                                        saturation:newSaturation
                                        brightness:newBrightness
                                             alpha:newAlpha];
        return newColour;
    }

    
}







@end













