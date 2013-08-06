#import "RecommendationNavigationController.h"

@interface RecommendationNavigationController ()

@end

@implementation RecommendationNavigationController

- (id)initWithExperienceRepository:(id<ExperienceRepositoryInterface>)experienceRepository imageRepository:(id<ImageRepositoryInterface>)imageRepository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setNavigationBarHidden:YES];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];

        ExperienceBuilder *experienceBuilder = [[ExperienceBuilder alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository locationManager:locationManager];
        
        self.photoViewController = [[PhotoViewController alloc] initWithExperienceBuilder:experienceBuilder];
        
        self.experienceRecommendationViewController =[[ExperienceRecommendationViewController alloc] initWithExperienceBuilder:experienceBuilder];
        
        [self pushViewController:self.photoViewController animated:YES];        
    }
    return self;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];    
}

@end
