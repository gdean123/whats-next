#import <Foundation/Foundation.h>
#import "LocationManagerInterface.h"
#import "LocationManagerDelegate.h"

@class LocationManager;

@interface LocationManager : NSObject <CLLocationManagerDelegate, LocationManagerInterface>

- (NSString *)getDistanceFromLocation:(CLLocation*)location;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void)registerForLocationUpdates:(id<LocationManagerDelegate>)subscriber;
- (void)unregisterForLocationUpdates:(id<LocationManagerDelegate>)subscriber;

@end
