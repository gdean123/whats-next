#import "ExperienceViewController.h"
#import "Experience.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "ExperienceBrowserViewController.h"


@interface ExperienceViewController ()

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
    CLLocationDistance distance = [self.locationManager getDistanceFromLatitude:[self.experience.latitude doubleValue] longitude:[self.experience.longitude doubleValue]];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", distance];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self refreshLocation];
    
    self.taglineLabel.text = self.experience.tagline;
    
    self.taglineLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.distanceLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *image = self.experience.image;
    
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]]; 
}

- (void)locationDidUpdate:(LocationManager *)locationManager
{
    [self refreshLocation];
}

@end
