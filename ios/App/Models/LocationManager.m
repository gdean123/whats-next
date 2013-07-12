#import "LocationManager.h"

@interface LocationManager()

- (NSString *)formatDistance:(CLLocationDistance)distance unit:(NSString *)unit fractionDigits:(int)fractionDigits;

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) CLLocationDirection currentHeading;

@end

@implementation LocationManager

@synthesize currentLocation;

@synthesize manager;

- (LocationManager *)init
{
    self = [super init];
    if (self)
    {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
            [self.manager startMonitoringSignificantLocationChanges];
        }
    }
    
    return self;
}

- (NSString *)getDistanceFromLocation:(CLLocation *)location
{
    const double THRESHOLD = 161.0;
    
    double distanceInMeters = [location distanceFromLocation:self.currentLocation];
    NSString *distanceString = @"0ft";
    
    if (distanceInMeters < THRESHOLD) {
        CLLocationDistance distance = [self getDistanceInFeetFromLocation:location];
        distanceString = [self formatDistance:distance unit:@"ft" fractionDigits:0];
    } else {
        CLLocationDistance distance = [self getDistanceInMilesFromLocation:location];
        distanceString = [self formatDistance:distance unit:@"mi" fractionDigits:1];
    }
    return distanceString;
}

- (NSString *)formatDistance:(CLLocationDistance)distance unit:(NSString *)unit fractionDigits:(int)fractionDigits
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:fractionDigits];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    
    NSString *distanceString = [formatter stringFromNumber:[NSNumber numberWithFloat:distance]];
    
    return [NSString stringWithFormat:@"%@%@", distanceString, unit];
}

- (CLLocationDistance)getDistanceInFeetFromLocation:(CLLocation*)location
{
    const double FEET_PER_METER = 3.28084;
    double distanceInMeters = [location distanceFromLocation:self.currentLocation];
    
    
    double distanceInFeet = distanceInMeters * FEET_PER_METER;
    double roundedDistanceInFeet = round(10.0f * distanceInFeet) / 10.0f;
    
    return roundedDistanceInFeet;
}

- (CLLocationDistance)getDistanceInMilesFromLocation:(CLLocation*)location
{
    const double MILES_PER_METER = 0.00062137;    
    double distanceInMeters = [location distanceFromLocation:self.currentLocation];
    
    
    double distanceInMiles = distanceInMeters * MILES_PER_METER;
    double roundedDistanceInMiles = round(10.0f * distanceInMiles) / 10.0f;
    
    return roundedDistanceInMiles;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = locations.lastObject;
    [self.delegate locationDidUpdate:self];
}

@end
