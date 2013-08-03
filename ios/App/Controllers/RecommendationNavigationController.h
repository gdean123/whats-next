#import <UIKit/UIKit.h>

#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"
#import "ImageRepositoryInterface.h"
#import "ExperienceRecommendationViewController.h"
#import "PhotoViewController.h"

@interface RecommendationNavigationController : UINavigationController

@property (nonatomic, strong) ExperienceRecommendationViewController *experienceRecommendationViewController;
@property (nonatomic, strong) PhotoViewController *photoViewController;

- (id)initWithExperienceRepository:(id<ExperienceRepositoryInterface>)experienceRepository imageRepository:(id<ImageRepositoryInterface>)imageRepository locationManager:(id<LocationManagerInterface>)locationManager;

@end
