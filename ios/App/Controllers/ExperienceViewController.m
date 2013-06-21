#import "ExperienceViewController.h"
#import "Experience.h"

@interface ExperienceViewController ()

@property (strong, nonatomic) Experience *experience;

@end

@implementation ExperienceViewController

- (id)initWithExperience:(Experience *)experience
{
    self = [super initWithNibName:@"ExperienceViewController" bundle:nil];
    if (self) {
        self.experience = experience;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taglineLabel.text = self.experience.tagline;
}

@end
