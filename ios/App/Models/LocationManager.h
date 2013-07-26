#import <Foundation/Foundation.h>
#import "LocationManagerInterface.h"

@class LocationManager;

@protocol LocationManagerDelegate

- (void)locationDidUpdate:(CLLocation *)location;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate, LocationManagerInterface>

- (NSString *)getDistanceFromLocation:(CLLocation*)location;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void)registerForLocationUpdates:(id<LocationManagerDelegate>)subscriber;
- (void)unregisterForLocationUpdates:(id<LocationManagerDelegate>)subscriber;

@property (nonatomic,assign) id<LocationManagerDelegate> delegate;

@end
