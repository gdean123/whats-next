#import "ExperienceRecommendationViewController.h"
#import "Experience.h"
#import "AppDelegate.h"

@interface ExperienceRecommendationViewController ()

@property (strong, nonatomic) ExperienceBuilder *experienceBuilder;

@end

@implementation ExperienceRecommendationViewController

-(ExperienceRecommendationViewController *)initWithExperienceBuilder:(ExperienceBuilder *)experienceBuilder
{
    self = [super initWithNibName:@"ExperienceRecommendationViewController" bundle:nil];
    if (self) {
        self.experienceBuilder = experienceBuilder;
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
    self.experienceBuilder.tagline = self.taglineTextField.text;
    
    [self.experienceBuilder createThen:^(Experience *experience) {
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
