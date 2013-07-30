#import "RecommendationNavigationController.h"
#import "ExperienceRecommendationViewController.h"

@interface RecommendationNavigationController ()

@end

@implementation RecommendationNavigationController

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
        [self setNavigationBarHidden:YES];
        
        ExperienceRecommendationViewController *experienceRecommendationViewController =[[ExperienceRecommendationViewController alloc] initWithRepository:repository locationManager:locationManager];
        
        [self pushViewController:experienceRecommendationViewController animated:YES];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end
