#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate

- (void)locationDidUpdate:(LocationManager *)locationManager;

@end


@interface LocationManager : NSObject <CLLocationManagerDelegate>

- (CLLocationDistance)getDistanceFromLocation:(CLLocation*)location;

@property (nonatomic,assign) id<LocationManagerDelegate> delegate;
@property (nonatomic, strong) CLLocation *currentLocation;

@end
