

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (KFXAdditions)


//--------------------------------------------------------
#pragma mark - Initilisation
//--------------------------------------------------------
-(instancetype)locationByAdjustingCoordinatesInDegreesWithLatitude:(CLLocationDegrees)latitudeAdjustment
                                            longitude:(CLLocationDegrees)longitudeAdjustment;
-(instancetype)locationByAdjustingCoordinatesInMetresWithLatitude:(double)latitudeAdjustment
                                           longitude:(double)longitudeAdjustment;

//--------------------------------------------------------
#pragma mark - Queries
//--------------------------------------------------------
#pragma mark Accuracy
-(BOOL)kfx_isDesiredHorizontalAccuracy:(CLLocationAccuracy)desiredAccuracy;
-(BOOL)kfx_isDesiredVerticalAccuracy:(CLLocationAccuracy)desiredAccuracy;

#pragma mark Freshness
-(BOOL)kfx_isFresh:(NSTimeInterval)desiredAge;
-(BOOL)kfx_isStale:(NSTimeInterval)desiredAge;
-(BOOL)kfx_isMoreRecentThan:(NSDate*)date;

#pragma mark Coordinate Validity
-(BOOL)kfx_isCoordinateValid;
-(BOOL)kfx_isCoordinateZeroZero;

#pragma mark Compare Locations
-(BOOL)kfx_isSameTimestampAs:(CLLocation*)otherLocation;
-(BOOL)kfx_isSameCoordinatesAs:(CLLocation*)otherLocation;
-(BOOL)kfx_isGreaterHorizontalAccuracyThan:(CLLocation*)otherLocation;
-(BOOL)kfx_isGreaterVerticalAccuracyThan:(CLLocation*)otherLocation;

//--------------------------------------------------------
#pragma mark - Formatting
//--------------------------------------------------------
#pragma mark Combined
-(NSString*)kfx_descriptionShort;
-(NSString*)kfx_descriptionMedium;
-(NSString*)kfx_descriptionFull;

#pragma mark Single Properties
-(NSString*)kfx_formattedCoordinates;
-(NSString*)kfx_formattedHorizontalAccuracy;
-(NSString*)kfx_formattedVerticalAccuracy;
-(NSString*)kfx_formattedSpeed;
-(NSString*)kfx_formattedCourse;
-(NSString*)kfx_formattedTimeStamp;

@end
