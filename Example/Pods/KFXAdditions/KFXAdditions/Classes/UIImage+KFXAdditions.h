

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (KFXAdditions)

#pragma mark - Resizing & Cropping
/**
 *  Returns a copy of this image that is cropped to the given bounds. This method ignores the image's imageOrientation setting.
 *
 *  @param bounds The bounds will be adjusted using CGRectIntegral.
 *
 *  @return A new UIImage cropped to bounds.
 */
- (UIImage *)kfx_croppedImage:(CGRect)bounds;


/**
 *  If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
 *
 *  @return a copy of this image that is squared to the thumbnail size.
 */
- (UIImage *)kfx_thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;


/**
 *  The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
 *
 *  @return a rescaled copy of the image, taking into account its orientation
 */
- (UIImage *)kfx_resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;


/**
 *  Resizes the image according to the given content mode, taking into account the image's orientation & preserving aspect ratio. Essentially resize + crop.
 *
 */
- (UIImage *)kfx_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;


#pragma mark - Alpha Channels

/**
 *  @return Returns true if the image has an alpha layer
 */
- (BOOL)kfx_hasAlpha;

/**
 *  @return Returns a copy of the given image, adding an alpha channel if it doesn't already have one
 */
- (UIImage *)kfx_imageWithAlpha;

/**
 *  If the image has no alpha layer, one will be added to it.
 *
 *  @return Returns a copy of the image with a transparent border of the given size added around its edges
 */
- (UIImage *)kfx_transparentBorderImage:(NSUInteger)borderSize;

#pragma mark - Rounded Corners
/**
 *  Creates a copy of this image with rounded corners
 *
 *  @param cornerSize Size of the corners
 *  @param borderSize If borderSize is non-zero, a transparent border of the given size will also be added
 *
 *  @return a copy of this image with rounded corners
 */
- (UIImage *)kfx_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

@end

NS_ASSUME_NONNULL_END
