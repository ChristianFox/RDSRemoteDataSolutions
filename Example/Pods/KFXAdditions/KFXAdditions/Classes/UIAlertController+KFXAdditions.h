


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (KFXAdditions)

//--------------------------------------------------------
#pragma mark - Convienence Initilisers
//--------------------------------------------------------
/// Convinience method to build an UIAlertController
+(UIAlertController*)kfx_alertControllerWithTitle:(NSString*_Nullable)title
                                      message:(NSString*_Nullable)message
                            singleButtonTitle:(NSString*)buttonTitle;

/// Convinience method to build an UIAlertController
+(UIAlertController*)kfx_alertControllerWithTitle:(NSString*_Nullable)title
                                      message:(NSString*_Nullable)message
                            singleButtonTitle:(NSString*)buttonTitle
                  buttonTappedCompletionBlock:(void(^_Nullable)(UIAlertAction *action))completionBlockOrNil;


/// Convinience method to build an UIAlertController
+(UIAlertController*)kfx_okayCancelAlertControllerWithTitle:(NSString*_Nullable)title
                                                message:(NSString*_Nullable)message
                                  cancelCompletionBlock:(void(^_Nullable)(UIAlertAction *action))cancelBlockOrNil
                                    okayCompletionBlock:(void(^_Nullable)(UIAlertAction *action))okayBlockOrNil;




@end
NS_ASSUME_NONNULL_END

