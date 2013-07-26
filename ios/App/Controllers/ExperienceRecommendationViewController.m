#import "ExperienceRecommendationViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceRecommendationViewController ()

@end

@implementation ExperienceRecommendationViewController

- (id)init
{
    self = [super initWithNibName:@"ExperienceRecommendationViewController" bundle:nil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
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
    
    ExperienceRepository *repository = [[ExperienceRepository alloc] init];
    
    Experience *experience = [[Experience alloc] initWithTagline:self.taglineTextField.text image:nil latitude:37.788319 longitude:-122.40744];
    [repository create:experience then:^(Experience * e) {
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
