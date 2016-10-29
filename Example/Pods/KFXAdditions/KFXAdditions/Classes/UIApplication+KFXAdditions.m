//
//  UIApplication+KFXAdditions.m
//  KFXUtilities
//
//  Created by Eyeye on 28/02/2016.
//  Copyright © 2016 kfxtech. All rights reserved.
//

#import "UIApplication+KFXAdditions.h"

@implementation UIApplication (KFXAdditions)


-(UIViewController *)kfx_topViewController{
    return [self kfx_topViewController:self.keyWindow.rootViewController];
}

- (UIViewController *)kfx_topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self kfx_topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self kfx_topViewController:presentedViewController];
}



@end
