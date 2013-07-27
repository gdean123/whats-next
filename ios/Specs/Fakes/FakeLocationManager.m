#import "FakeLocationManager.h"

@implementation FakeLocationManager

@synthesize currentLocation;

- (FakeLocationManager *)initWithLatitude:(double)latitude longitude:(double)longitude
{
    FakeLocationManager* fakeLocationManager = [[FakeLocationManager alloc] init];
    
    if (fakeLocationManager) {
        fakeLocationManager.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return fakeLocationManager;
}

- (void)registerForLocationUpdates:(id<LocationManagerDelegate>)subscriber
{
}

- (NSString *)getDistanceFromLocation:(CLLocation*)location
{
    return @"invalide distance";
}

@end
