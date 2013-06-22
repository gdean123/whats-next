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
}

- (void)loadExperience
{
    [self.experienceRepository get:@2
                              then:^(Experience *experience) {
                                  self.currentExperienceViewController = [[ExperienceViewController alloc] initWithExperience:experience];
                              }];
}
@end
