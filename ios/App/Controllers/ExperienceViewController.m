#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

#import "ExperienceViewController.h"
#import "Experience.h"
#import "ExperienceBrowserViewController.h"

@interface ExperienceViewController ()

@property (strong, nonatomic) Experience *experience;
@property (weak, nonatomic) LocationManager *locationManager;

@end

@implementation ExperienceViewController

- (id)initWithExperience:(Experience *)theExperience locationManager:(LocationManager *)theLocationManager
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
    
    if (self.locationManager.currentLocation != nil) {
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
    NSString *image = self.experience.image;    
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]]; 
}

- (void)locationDidUpdate:(CLLocation *)location
{
    [self refreshLocation];
}

@end
