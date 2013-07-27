#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate

- (void)locationDidUpdate:(CLLocation *)location;

@end