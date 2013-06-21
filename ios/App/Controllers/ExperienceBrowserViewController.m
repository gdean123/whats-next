#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

@property (nonatomic, strong) id<Repository> experienceRepository;

@end

@implementation ExperienceBrowserViewController

- (id)initWithRepository:(id<Repository>)repository
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
    [self.experienceRepository get:@2
               then:^(Experience *e){
//                   self.taglineLabel.text = e.tagline;
               }];
}

@end
