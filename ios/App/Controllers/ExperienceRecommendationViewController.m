#import "ExperienceRecommendationViewController.h"
#import "Experience.h"

@interface ExperienceRecommendationViewController ()

@property (strong, nonatomic) id<ExperienceRepositoryInterface> repository;
@property (strong, nonatomic) id<LocationManagerInterface> locationManager;

@end

@implementation ExperienceRecommendationViewController

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager
{
    self = [super initWithNibName:@"ExperienceRecommendationViewController" bundle:nil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
        self.repository = repository;
        self.locationManager = locationManager;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taglineTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.taglineTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.taglineTextField resignFirstResponder];
    
    double latitude = [self.locationManager currentLocation].coordinate.latitude;
    double longitude = [self.locationManager currentLocation].coordinate.longitude;
    
    Experience *experience = [[Experience alloc] initWithTagline:self.taglineTextField.text image:nil latitude:latitude longitude:longitude];
    
    [self.repository create:experience then:^(Experience * e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Your experience has been created!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];   
    
    return NO;
}

@end
