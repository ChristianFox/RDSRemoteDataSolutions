

#import "NSKeyedArchiver+KFXAdditions.h"

@implementation NSKeyedArchiver (KFXAdditions)

+(BOOL)kfx_archiveRootObject:(id)object
             toDirectoryPath:(NSString *)dirPath
                withFileName:(NSString *)fileName
                       error:(NSError * _Nullable __autoreleasing *)error{
    
    
    BOOL success = NO;
    
    NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
    success = [NSKeyedArchiver archiveRootObject:object
                                          toFile:fullPath];
    if (!success) {
        if (error != nil) {
            
            BOOL isDirectory = NO;
            NSString *message;
            
            if (object == nil) {
                
                message = NSLocalizedString(@"The object to archive is nil",@"");
                
            }else if (fileName == nil){
                
                message = NSLocalizedString(@"The fileName to use when archiving is nil",@"");
                
            }else if (dirPath == nil){
                
                message = NSLocalizedString(@"The directoryPath is nil",@"");
                
            }else if (![[NSFileManager defaultManager]fileExistsAtPath:dirPath]){
                
                message = NSLocalizedString(@"The directoryPath is invalid",@"");
                
            }else if ([[NSFileManager defaultManager]fileExistsAtPath:dirPath isDirectory:&isDirectory]
                      && !isDirectory){
                
                message = NSLocalizedString(@"The directoryPath points to a file not a directory",@"");
                
            }else{
                
                message = NSLocalizedString(@"Unknown Error when attempting to archive",@"");
                
            }
            
            *error = [NSError errorWithDomain:@"com.KFXTech.KFXAdditions.NSKeyedArchiver+KFXAdditions"
                                         code:0
                                     userInfo:@{NSLocalizedDescriptionKey:message}];
        }
    }
    
    
    return success;

    
}

@end
