#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

@property (nonatomic, strong) ExperienceRepository *experienceRepository;

@end

@implementation ExperienceBrowserViewController

- (id)initWithRepository:(ExperienceRepository *)repository
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.experienceRepository get:@10
               then:^(Experience *e){
                   self.taglineLabel.text = e.tagline;
               }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
