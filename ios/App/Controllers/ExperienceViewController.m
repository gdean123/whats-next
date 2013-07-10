#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

#import "ExperienceViewController.h"
#import "Experience.h"
#import "ExperienceBrowserViewController.h"

@interface ExperienceViewController ()

- (NSString *)formatDistance:(CLLocationDistance)distance;

@property (strong, nonatomic) Experience *experience;
@property (weak, nonatomic) LocationManager *locationManager;

@end

@implementation ExperienceViewController

- (id)initWithExperience:(Experience *)experience locationManager:(LocationManager *)locationManager
{
    self = [super initWithNibName:@"ExperienceViewController" bundle:nil];
    if (self) {
        self.experience = experience;
        self.locationManager = locationManager;
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)refreshLocation
{
    CLLocationDegrees latitude = [self.experience.latitude doubleValue];
    CLLocationDegrees longitude = [self.experience.longitude doubleValue];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    self.distanceLabel.text = [self.locationManager getDistanceFromLocation:location];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshLocation];
    
    self.taglineLabel.text = self.experience.tagline;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *image = self.experience.image;
    
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]]; 
}

- (void)locationDidUpdate:(LocationManager *)locationManager
{
    [self refreshLocation];
}

@end
