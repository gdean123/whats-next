#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"
#import "ExperienceBrowserScrollView.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

- (void)appendExperiencesForGroup:(int)group;
- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)manager forIndex:(int)i;
- (void)appendExperiences:(NSArray *)experiences startingAtIndex:(int)index;
@property (nonatomic, strong) id<ExperienceRepositoryInterface> experienceRepository;

@end

@implementation ExperienceBrowserViewController

@synthesize locationManager;

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
        self.locationManager = [[LocationManager alloc] init];
        self.spinnerViewController = [[SpinnerViewController alloc] init];
        
        // associate tabbar item
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.experienceBrowserScrollViewDelegate = self;
    
    [self addSpinner];
    [self appendExperiencesForGroup:1];
}

- (void)appendExperiencesForGroup:(int)group
{    
    [self.experienceRepository getGroup:group then:^(NSArray *experiences) {
        if (!experiences || [experiences count] == 0) return;
        
        [self removeSpinner];
        [self appendExperiences:experiences startingAtIndex:(3 * (group- 1))];
        [self addSpinner];
    }];
}

- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)theLocationManager forIndex:(int)i
{
    ExperienceViewController *experienceViewController = [[ExperienceViewController alloc] initWithExperience:experience locationManager:theLocationManager];
    
    [self addChild:experienceViewController atPage:i];
    
    return experienceViewController;
}

- (void)scrollViewDidSwipeInDirection:(ScrollDirection)scrollDirection
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.currentViewController = self.childViewControllers[page];

    if (scrollDirection == ScrollDirectionRight) {
        bool pageIsFirstInGroup = (page % 3 == 0);
        if (pageIsFirstInGroup) {
            [self appendExperiencesForGroup:(page/3) + 1];
        }
    }
}

- (void)addChild:(UIViewController *)child atPage:(int)page
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = CGRectGetWidth(frame) * page;
    frame.origin.y = 0;
    child.view.frame = frame;
    
    [self addChildViewController:child];
    [self.scrollView addSubview:child.view];
    [child didMoveToParentViewController:self];
}

- (void)removeSpinner
{
    [self.spinnerViewController.view removeFromSuperview];
    [self.spinnerViewController removeFromParentViewController];
}

- (void)addSpinner
{
    [self addChild:self.spinnerViewController atPage:[self.childViewControllers count]];
}

- (void)appendExperiences:(NSArray *)experiences startingAtIndex:(int)index
{
    for (int i = 0; i < [experiences count]; i++) {
        [self createViewControllerForExperience:experiences[i] withLocationManager:self.locationManager forIndex:i + index];
    }
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * ([self.childViewControllers count] + 1), CGRectGetHeight(self.scrollView.frame));
    self.currentViewController = self.childViewControllers[index];
}
@end
