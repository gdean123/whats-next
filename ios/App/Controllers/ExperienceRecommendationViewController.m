#import "ExperienceRecommendationViewController.h"
#import "Experience.h"
#import "AppDelegate.h"

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
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    
    [self.recommendButton addTarget:self action:@selector(recommendButtonClick:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.taglineTextField becomeFirstResponder];
}

- (void)createExperience
{
    double latitude = [self.locationManager currentLocation].coordinate.latitude;
    double longitude = [self.locationManager currentLocation].coordinate.longitude;
    
    Experience *experience = [[Experience alloc] initWithTagline:self.taglineTextField.text image:nil latitude:latitude longitude:longitude];
    
    [self.repository create:experience then:^(Experience * e) {        
        [self.delegate experienceWasCreated];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.taglineTextField resignFirstResponder];
    
    [self createExperience];
    
    return NO;
}

-  (void)recommendButtonClick:(id)sender {
    [self createExperience];
}

-  (void)cancelButtonClick:(id)sender {
    [self switchToTab:0];
}

- (void)switchToTab:(int)tab
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabBarController setSelectedIndex:tab];
}
@end
