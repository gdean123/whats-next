#import <UIKit/UIKit.h>

#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"
#import "ExperienceRecommendationViewController.h"
#import "PhotoViewController.h"


@interface RecommendationNavigationController : UINavigationController

@property (nonatomic, strong) ExperienceRecommendationViewController *experienceRecommendationViewController;
@property (nonatomic, strong) PhotoViewController *photoViewController;

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;

@end
