#import <UIKit/UIKit.h>

#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"

@interface RecommendationNavigationController : UINavigationController

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;

@end
