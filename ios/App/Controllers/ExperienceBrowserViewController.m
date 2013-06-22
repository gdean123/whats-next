#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

@property (nonatomic, strong) id<Repository> experienceRepository;

- (void)loadExperience;

@end

@implementation ExperienceBrowserViewController

- (id)initWithRepository:(id<Repository>)repository
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
        
        [self loadExperience];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)loadExperience
{
    [self.experienceRepository get:@10
                              then:^(Experience *experience) {
                                  self.currentExperienceViewController = [[ExperienceViewController alloc] initWithExperience:experience];
                                  
                                  [self.scrollView addSubview:self.currentExperienceViewController.view];
                              }];
}
@end
