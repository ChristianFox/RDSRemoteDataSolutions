


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSKeyedArchiver (KFXAdditions)

+(BOOL)kfx_archiveRootObject:(id)object
             toDirectoryPath:(NSString*)dirPath
                withFileName:(NSString*)fileName
                       error:(NSError *__autoreleasing  _Nullable *)error;

@end
NS_ASSUME_NONNULL_END
