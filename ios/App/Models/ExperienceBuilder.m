#import "ExperienceBuilder.h"
#import "Experience.h"

@implementation ExperienceBuilder

-(ExperienceBuilder *)initWithExperienceRepository:(id<ExperienceRepositoryInterface>)experienceRepository imageRepository:(id<ImageRepositoryInterface>)imageRepository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [[ExperienceBuilder alloc] init];
    
    if (self) {
        self.experienceRepository = experienceRepository;
        self.imageRepository = imageRepository;
        self.locationManager = locationManager;
    }
    
    return self;
}

- (void)createThen:(void (^) (Experience *))successBlock
{
    [self.imageRepository create:self.image then:^(NSString *imageUrl) {
        CLLocationCoordinate2D location = self.locationManager.currentLocation.coordinate;
        
        Experience *experience = [[Experience alloc] initWithTagline:self.tagline imageUrl:imageUrl latitude:location.latitude longitude:location.longitude];
        
        [self.experienceRepository create:experience then:successBlock];
    }];
}

@end
