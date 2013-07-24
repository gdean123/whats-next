#import "ExperienceRecommendationViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceRecommendationViewController ()

@end

@implementation ExperienceRecommendationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taglineTextField.delegate = self;
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
