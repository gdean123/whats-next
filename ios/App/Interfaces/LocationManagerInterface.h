#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerInterface <NSObject>

@property (nonatomic, strong) CLLocation *currentLocation;

@end
