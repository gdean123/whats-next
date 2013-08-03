#import "ExperienceBuilder.h"
#import "Experience.h"

@implementation ExperienceBuilder

-(ExperienceBuilder *)initWithRepository:(id<ExperienceRepositoryInterface>)experienceRepository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [[ExperienceBuilder alloc] init];
    
    if (self) {
        self.experienceRepository = experienceRepository;
        self.locationManager = locationManager;
    }
    
    return self;
}

- (void)createThen:(void (^) (Experience *))successBlock
{
    CLLocationCoordinate2D location = self.locationManager.currentLocation.coordinate;
    
    Experience *experience = [[Experience alloc] initWithTagline:self.tagline image:self.image latitude:location.latitude longitude:location.longitude];
    
    [self.experienceRepository create:experience then:successBlock];
}

@end
