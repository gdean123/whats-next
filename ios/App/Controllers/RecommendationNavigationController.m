#import "RecommendationNavigationController.h"

@interface RecommendationNavigationController ()

@end

@implementation RecommendationNavigationController

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setNavigationBarHidden:YES];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
        
        self.photoViewController = [[PhotoViewController alloc] init];
        
        self.experienceRecommendationViewController =[[ExperienceRecommendationViewController alloc] initWithRepository:repository locationManager:locationManager];
        
        [self pushViewController:self.photoViewController animated:YES];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];    
}
@end
