

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSKeyedUnarchiver (KFXAdditions)

+(id)kfx_unarchiveObjectFromDirectoryPath:(NSString*)dirPath
                             withFileName:(NSString*)fileName
                                    error:(NSError *__autoreleasing  _Nullable *)error;


@end
NS_ASSUME_NONNULL_END
