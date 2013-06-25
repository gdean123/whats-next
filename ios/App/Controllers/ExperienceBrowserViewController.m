#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

@property (nonatomic, strong) id<Repository> experienceRepository;

- (void)loadExperiences;

@property (nonatomic, strong) NSMutableArray *experienceViewControllers;

@end

@implementation ExperienceBrowserViewController

@synthesize experienceViewControllers = _experienceViewControllers;

- (NSMutableArray *)experienceViewControllers
{
    if (!_experienceViewControllers)
    {
        _experienceViewControllers = [[NSMutableArray alloc] init];
    }
    
    return _experienceViewControllers;
}

- (id)initWithRepository:(id<Repository>)repository
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
        
        self.scrollView.delegate = self;
        
        [self loadExperiences];
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

- (void)loadExperiences
{
    [self.experienceRepository getAllThen:^(NSArray *experiences) {
        if (!experiences || [experiences count] == 0) return;
        
        self.scrollView.contentSize =
        CGSizeMake(CGRectGetWidth(self.scrollView.frame) * [experiences count], CGRectGetHeight(self.scrollView.frame));        
        
        for (int i = 0; i < [experiences count]; i++) {
            ExperienceViewController *experienceViewController = [self createViewControllerForExperience:experiences[i] forIndex:i];
            [self.experienceViewControllers addObject:experienceViewController];
        }
        
        self.currentExperienceViewController = self.experienceViewControllers[0];        
    }];
}

- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience forIndex:(int)i
{
    ExperienceViewController *experienceViewController = [[ExperienceViewController alloc] initWithExperience:experience];   

    CGRect frame = self.scrollView.frame;
    frame.origin.x = CGRectGetWidth(frame) * i;
    frame.origin.y = 0;
    experienceViewController.view.frame = frame;
    
    [self addChildViewController:experienceViewController];
    [self.scrollView addSubview:experienceViewController.view];
    [experienceViewController didMoveToParentViewController:self];
    
    return experienceViewController;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.currentExperienceViewController = self.experienceViewControllers[page];
}
@end
