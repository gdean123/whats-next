#import "ExperienceViewController.h"
#import "Experience.h"
#import <QuartzCore/QuartzCore.h>

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
    
    self.taglineLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];    
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *image = self.experience.image;
    
    (void)[self.imageView initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]];
 
}

@end
