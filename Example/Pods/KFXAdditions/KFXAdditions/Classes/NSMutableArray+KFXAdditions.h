


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSMutableArray (KFXAdditions)

/**
 * Checks if the object is nil and if it is not it adds the object to the array using --addObject:. If the object is nil then it does nothing but doesn't crash.
 * @param object The object you want to add to the array. Can be nil.
 * @return YES if the object was added, NO if it was not.
 * @since 0.10.0
 **/
-(BOOL)kfx_addObject:(id __nullable)object;

@end
NS_ASSUME_NONNULL_END
