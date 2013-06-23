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

    self.scrollView.pagingEnabled = YES;    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;   
}

- (void)loadExperience
{
    [self.experienceRepository getAllThen:^(NSArray *experiences) {
        if (experiences && [experiences count] != 0)
        {
            self.scrollView.contentSize =
            CGSizeMake(CGRectGetWidth(self.scrollView.frame) * [experiences count], CGRectGetHeight(self.scrollView.frame));
            
            
            for (int i = 0; i < [experiences count]; i++) {
                
                Experience *experience = experiences[i];
                
                ExperienceViewController *experienceViewController = [[ExperienceViewController alloc] initWithExperience:experience];

                if (!self.currentExperienceViewController)
                {
                    self.currentExperienceViewController = experienceViewController;
                }
                
                CGRect frame = self.scrollView.frame;
                frame.origin.x = CGRectGetWidth(frame) * i;
                frame.origin.y = 0;
                experienceViewController.view.frame = frame;
                
                [self addChildViewController:experienceViewController];
                [self.scrollView addSubview:experienceViewController.view];
                [experienceViewController didMoveToParentViewController:self];              
            }
        }
        else{
//            @throw [NSException exceptionWithName:@"NoImplementation"
//                                           reason:@"Should finish the case that database has no experiences"
//                                         userInfo:nil];
        }
            
    }];
}
@end
