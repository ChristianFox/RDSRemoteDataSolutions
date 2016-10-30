



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


//======================================================
#pragma mark - ** Colours **
//======================================================
/* Pink becuase there is no pink by default. */
+(instancetype)kfx_pinkColour;

#pragma mark Highlight Markers
/* Based on the Marker colours in Scrivener */
+(instancetype)kfx_yellowHighlightColour;
+(instancetype)kfx_orangeHighlightColour;
+(instancetype)kfx_pinkHighlightColour;
+(instancetype)kfx_greenHighlightColour;
+(instancetype)kfx_blueHighlightColour;

#pragma mark System Colours
+(instancetype)kfx_iOS7BlueColour;
+(instancetype)kfx_scrollViewTexturedBackgroundColour;
+(instancetype)kfx_viewFlipsideBackgroundColour;

#pragma mark Pastels
/* Pastels. Brightness == 100%, Saturation == 16% & varied Hue */
+(instancetype)kfx_pastelRed;
+(instancetype)kfx_pastelOrange;
+(instancetype)kfx_pastelYellow;
+(instancetype)kfx_pastelGreenLight;
+(instancetype)kfx_pastelGreenDark;
+(instancetype)kfx_pastelBlueLight;
+(instancetype)kfx_pastelBlueDark;
+(instancetype)kfx_pastelPurple;
+(instancetype)kfx_pastelPink;

#pragma mark Crayons
/* Based on Crayons in OSX color picker */
// Foods
+(instancetype)kfx_cayenneColour;
+(instancetype)kfx_asparagusColour;
+(instancetype)kfx_plumColour;
+(instancetype)kfx_mochaColour;
+(instancetype)kfx_eggplantColour;
+(instancetype)kfx_lemonColour;
+(instancetype)kfx_blueberryColour;
+(instancetype)kfx_tangerineColour;
+(instancetype)kfx_limeColour;
+(instancetype)kfx_grapeColour;
+(instancetype)kfx_strawberryColour;
+(instancetype)kfx_salmonColour;
+(instancetype)kfx_bananaColour;
+(instancetype)kfx_bubblegumColour;
+(instancetype)kfx_cantaloupeColour;
+(instancetype)kfx_honeydewColour;
+(instancetype)kfx_licoriceColour;
// Plants
+(instancetype)kfx_cloverColour;
+(instancetype)kfx_fernColour;
+(instancetype)kfx_mossColour;
+(instancetype)kfx_floraColour;
+(instancetype)kfx_orchidColour;
+(instancetype)kfx_lavenderColour;
+(instancetype)kfx_carnationColour;
// Metals
+(instancetype)kfx_tinColour;
+(instancetype)kfx_nickelColour;
+(instancetype)kfx_steelColour;
+(instancetype)kfx_aluminumColour;
+(instancetype)kfx_ironColour;
+(instancetype)kfx_magnesiumColour;
+(instancetype)kfx_tungstenColour;
+(instancetype)kfx_silverColour;
+(instancetype)kfx_leadColour;
+(instancetype)kfx_mercuryColour;
// Watery
+(instancetype)kfx_oceanColour;
+(instancetype)kfx_seaFoamColour;
+(instancetype)kfx_aquaColour;
+(instancetype)kfx_iceColour;
+(instancetype)kfx_snowColour;
// misc
+(instancetype)kfx_tealColour;
+(instancetype)kfx_maroonColour;
+(instancetype)kfx_turquoiseColour;
+(instancetype)kfx_magentaColour;
+(instancetype)kfx_midnightColour;
+(instancetype)kfx_maraschinoColour;
+(instancetype)kfx_springColour;
+(instancetype)kfx_spindriftColour;
+(instancetype)kfx_skyColour;




@end

NS_ASSUME_NONNULL_END



