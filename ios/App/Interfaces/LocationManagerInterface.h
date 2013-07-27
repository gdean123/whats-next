#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "LocationManagerDelegate.h"

@protocol LocationManagerInterface <NSObject>

@property (nonatomic, strong) CLLocation *currentLocation;

- (void)registerForLocationUpdates:(id<LocationManagerDelegate>)subscriber;
- (NSString *)getDistanceFromLocation:(CLLocation*)location;

@end
