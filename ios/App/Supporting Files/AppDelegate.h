#import <UIKit/UIKit.h>
#import "LocationManagerDelegate.h"

@class ExperienceRepository, LocationManager, ImageRepository;

@interface AppDelegate : UIResponder <UIApplicationDelegate, LocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) ExperienceRepository *experienceRepository;
@property (strong, nonatomic) ImageRepository *imageRepository;
@property (strong, nonatomic) LocationManager *locationManager;

@end
