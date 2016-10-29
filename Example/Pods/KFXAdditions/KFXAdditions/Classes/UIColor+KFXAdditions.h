



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (KFXAdditions)


//--------------------------------------------------------
#pragma mark - Hex Colours
//--------------------------------------------------------
/**
 * @brief Create a UIColor from a hex string
 * @param hexStr A NSString representing a hex colour value. Should be in either the #FFF or #FFFFFF format.
 * @param alpha The value to use for the alpha channel. Should be between 0.0 & 1.0
 * @return A UIColor object representing the same colour as defined by the hexStr parameter
 * @ref  http://iosdevelopertips.com/conversion/how-to-create-a-uicolor-object-from-a-hex-value.html
 **/
+ (UIColor *)kfx_colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;


//--------------------------------------------------------
#pragma mark - Random Colours
//--------------------------------------------------------
/**
 * @brief Generate a UIColor with random values for Hue, Saturation, Brightness and Alpha in between 0.0 & 1.0
 * @return A UIColor object with random colour
 * @since 0.12.0
 **/
+(UIColor*)kfx_randomColour;

/**
 * @brief Generate a UIColor with random values for Hue, Saturation and Brightness in between 0.0 & 1.0 with the specified Alpha value
 * @param alpha The value to use for the alpha channel. Should be between 0.0 & 1.0
 * @return A UIColor object with random colour
 * @since 0.12.0
 **/
+(UIColor*)kfx_randomColourWithAlpha:(CGFloat)alpha;

/**
 * @brief Generate a UIColor with random values for Hue in between 0.0 & 1.0 and random values for Saturation and Brightness in between 0.5 and 1.0. The alpha value can be specified or a random value can be used.
 * @param alpha The alpha value for the colour. If less than 0.0 a random alpha value will be used. If greater than 1.0 then 1.0 will be used.
 * @return A UIColor object with random colour where saturation & brightness are both guaranteed to be at least 0.5.
 * @since 0.12.0
 * @ref http://stackoverflow.com/questions/21130433/generate-a-random-uicolor
 * @ref https://gist.github.com/kylefox/1689973
 **/
+(UIColor*)kfx_randomColourAvoidingBlackAndWhiteWithAlpha:(CGFloat)alpha;


//--------------------------------------------------------
#pragma mark - Alter Colours
//--------------------------------------------------------
/**
 * @brief Creates a new UIColor by taking the receivers colour and altering the Hue by the given amount
 * @param amount The amount to alter the Hue by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @return A new UIColor object. If the recevier is not in a compatible color space then nil will be returned.
 * @since 0.12.0
 **/
-(UIColor*_Nullable )kfx_colourByAlteringHueByAmount:(CGFloat)amount;

/**
 * @brief Creates a new UIColor by taking the receivers colour and altering the Saturation by the given amount
 * @param amount The amount to alter the Saturation by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @return A new UIColor object. If the recevier is not in a compatible color space then nil will be returned.
 * @since 0.12.0
 **/
-(UIColor*_Nullable)kfx_colourByAlteringSaturationByAmount:(CGFloat)amount;


/**
 * @brief Creates a new UIColor by taking the receivers colour and altering the Brightness by the given amount
 * @param amount The amount to alter the Brightness by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @return A new UIColor object. If the recevier is not in a compatible color space then nil will be returned.
 * @since 0.12.0
 **/
-(UIColor*_Nullable)kfx_colourByAlteringBrightnessByAmount:(CGFloat)amount;

/**
 * @brief Creates a new UIColor by taking the receivers colour and altering the Alpha by the given amount
 * @param amount The amount to alter the Alpha by. Should be between -1.0 & 1.0.
 * @return A new UIColor object. If the recevier is not in a compatible color space then nil will be returned.
 * @since 0.12.0
 **/
-(UIColor*_Nullable)kfx_colourByAlteringAlphaByAmount:(CGFloat)amount;


/**
 * @brief Creates a new UIColor by taking the receivers colour and altering the values by the given amounts
 * @param hue The amount to alter the Hue by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @param saturation The amount to alter the Saturation by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @param brightness The amount to alter the Brightness by. Prior to iOS 10 should be between -1.0 & 1.0, on iOS 10 and later can be any values.
 * @param alpha The amount to alter the Alpha by. Should be between -1.0 & 1.0.
 * @return A new UIColor object. If the recevier is not in a compatible color space then nil will be returned.
 * @since 0.12.0
 **/
-(UIColor*_Nullable)kfx_colourByAlteringHue:(CGFloat)hue
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                      alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END



