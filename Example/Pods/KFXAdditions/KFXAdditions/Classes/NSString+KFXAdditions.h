


#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, KFXStringComponent) {
    KFXStringComponentNone = 0,
    KFXStringComponentAlpha = 1 << 0,
    KFXStringComponentNumerical = 1 << 1,
    KFXStringComponentSymbolsCommon = 1 << 2,
    KFXStringComponentSymbolsExtensive = 1 << 3,
};

NS_ASSUME_NONNULL_BEGIN@interface NSString (KFXAdditions)


//======================================================
#pragma mark - ** Class Methods **
//======================================================
+(NSString*__nullable)kfx_randomStringOfLength:(int)length DEPRECATED_ATTRIBUTE;
+(NSString*)kfx_randomStringOfLength:(int)length withStringComponents:(KFXStringComponent)components;
+(NSString*)kfx_randomStringOfLength:(int)length fromCharacterPool:(NSString*)characterPool;
+(NSString*__nullable)kfx_stringByCombiningComponents:(NSArray<NSString*>*)components separatedByString:(NSString*)separator;



//======================================================
#pragma mark - ** Instance Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Queries
//--------------------------------------------------------
-(BOOL)kfx_containsOnlySignedDecimalDigits;
-(BOOL)kfx_containsAlphaNumericCharacters;
-(NSUInteger)kfx_occurancesOfString:(NSString*)subString options:(NSStringCompareOptions)options;

//--------------------------------------------------------
#pragma mark - New String with edits
//--------------------------------------------------------
-(NSString*)kfx_stringByCapitalisingFirstLetter;
-(NSString*)kfx_stringByAddingPercentEscapesUsingEncoding:(CFStringEncoding)encoding;
/// Creates a new string and replaces any white space with a length greater than 1 with a single space. If the receiver does not contain any excessive white space it is returned
-(NSString*)kfx_stringByRemovingExcessiveWhiteSpace;
-(NSString*)kfx_stringByTrimmingWhiteSpaceAndNewLines;

//--------------------------------------------------------
#pragma mark - Attributed String
//--------------------------------------------------------
-(NSAttributedString *)kfx_attributeStringWithAttributes:(NSDictionary *)attributes;


@end
NS_ASSUME_NONNULL_END
