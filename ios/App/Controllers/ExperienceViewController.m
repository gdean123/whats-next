#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

#import "ExperienceViewController.h"
#import "Experience.h"
#import "ExperienceBrowserViewController.h"
#import "LocationManagerInterface.h"

@interface ExperienceViewController ()

@property (strong, nonatomic) Experience *experience;
@property (weak, nonatomic) id<LocationManagerInterface> locationManager;

@end

@implementation ExperienceViewController

- (id)initWithExperience:(Experience *)theExperience locationManager:(id<LocationManagerInterface>)theLocationManager
{
    self = [super initWithNibName:@"ExperienceViewController" bundle:nil];
    if (self) {
        self.experience = theExperience;
        self.locationManager = theLocationManager;
        [self.locationManager registerForLocationUpdates:self];
    }
    return self;
}

- (void)refreshLocation
{
    CLLocationDegrees experienceLatitude = self.experience.latitude;
    CLLocationDegrees experienceLongitude = self.experience.longitude;
    CLLocation *experienceLocation = [[CLLocation alloc] initWithLatitude:experienceLatitude longitude:experienceLongitude];    
    
    if ([self.locationManager currentLocation] != nil) {
        self.distanceLabel.text = [self.locationManager getDistanceFromLocation:experienceLocation];
        [self.distanceLabel setHidden:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshLocation];
    
    self.taglineLabel.text = self.experience.tagline;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;    
    NSString *imageUrl = self.experience.imageUrl;
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]]];
}

- (void)locationDidUpdate:(CLLocation *)location
{
    [self refreshLocation];
}

@end
