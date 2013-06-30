#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate

- (void)locationDidUpdate:(LocationManager *)locationManager;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

- (CLLocationDistance)getDistanceFromLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

@property (nonatomic,assign) id<LocationManagerDelegate> delegate;

@end
