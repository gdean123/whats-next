#import "LocationManager.h"

@interface LocationManager()

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

- (CLLocationDistance)getDistanceFromLocation:(CLLocation*)location
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
