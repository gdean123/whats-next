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
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taglineLabel.text = self.experience.tagline;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *image = self.experience.image;
    
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]]; 
}

- (void)locationDidUpdate:(CLLocation *)location
{
    CLLocationDegrees experienceLatitude = [self.experience.latitude doubleValue];
    CLLocationDegrees experienceLongitude = [self.experience.longitude doubleValue];
    CLLocation *experienceLocation = [[CLLocation alloc] initWithLatitude:experienceLatitude longitude:experienceLongitude];
    
    self.distanceLabel.text = [self.locationManager getDistanceFromLocation:experienceLocation];
    [self.distanceLabel setHidden:NO];
}

@end
