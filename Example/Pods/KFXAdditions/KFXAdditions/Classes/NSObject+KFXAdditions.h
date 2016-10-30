


#import <Foundation/Foundation.h>

@interface NSObject (KFXAdditions)


#pragma mark - Properties of a class (introspection?)
+ (NSDictionary *)kfx_propertiesOfClass:(Class)klass;



#pragma mark - Blocks 
-(void)kfx_waitUntilDone:(void(^)(void))waitBlock;

/**
 * @ref http://www.brianjcoleman.com/tutorial-run-a-block-of-code-after-a-delay/
 **/
-(void)kfx_performBlock: (dispatch_block_t) block
           afterDelay: (NSTimeInterval) delay;


@end
