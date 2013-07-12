#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate

- (void)locationDidUpdate:(CLLocation *)location;

@end


@interface LocationManager : NSObject <CLLocationManagerDelegate>

- (NSString *)getDistanceFromLocation:(CLLocation*)location;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@property (nonatomic,assign) id<LocationManagerDelegate> delegate;
@property (nonatomic, strong) CLLocation *currentLocation;

@end
