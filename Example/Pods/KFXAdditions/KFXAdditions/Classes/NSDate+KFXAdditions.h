


#import <Foundation/Foundation.h>

@interface NSDate (KFXAdditions)

-(BOOL)kfx_isLaterThanDate:(NSDate*)anotherDate;
-(BOOL)kfx_isEarlierThanDate:(NSDate*)anotherDate;

-(BOOL)kfx_isBetweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate;

@end
