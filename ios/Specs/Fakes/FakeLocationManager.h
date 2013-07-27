#import <Foundation/Foundation.h>
#import "LocationManagerInterface.h"

@interface FakeLocationManager : NSObject<LocationManagerInterface>

- (FakeLocationManager *)initWithLatitude:(double)latitude longitude:(double)longitude;
- (void)registerForLocationUpdates:(id<LocationManagerDelegate>)subscriber;
- (NSString *)getDistanceFromLocation:(CLLocation*)location;

@end
