#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"
#import "ExperienceBrowserScrollView.h"
#import "LocationManagerInterface.h"
#import "Experience.h"
#import "AppDelegate.h"

@interface ExperienceBrowserViewController ()

- (void)appendExperiencesForGroup:(int)group new:(BOOL)new;
- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(id<LocationManagerInterface>)theLocationManager forIndex:(int)i;
- (void)appendExperiences:(NSArray *)experiences startingAtIndex:(int)index;

@property (nonatomic, strong) id<ExperienceRepositoryInterface> experienceRepository;
@property (nonatomic, strong) id<LocationManagerInterface> locationManager;

@end

@implementation ExperienceBrowserViewController

@synthesize locationManager;

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)theRepository locationManager:(id<LocationManagerInterface>)theLocationManager
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = theRepository;
        self.locationManager = theLocationManager;
        self.spinnerViewController = [[SpinnerViewController alloc] init];
        
        // associate tabbar item
        UIImage *tabarImage = [UIImage imageNamed:@"thumb-up"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Experiences" image:tabarImage tag:0];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.experienceBrowserScrollViewDelegate = self;
    
    [self addSpinner];
    [self appendExperiencesForGroup:1 new:FALSE];
}

- (void)appendExperiencesForGroup:(int)group new:(BOOL)new
{
    CLLocation *currentLocation = [self.locationManager currentLocation];
    
    [self.experienceRepository getGroup:group near:currentLocation then:^(NSArray *experiences) {
        if (!experiences || [experiences count] == 0) return;
        
        [self removeSpinner];
        [self appendExperiences:experiences startingAtIndex:(3 * (group - 1))];
        [self addSpinner];
        
        if (new) [ self showNewExperience];
    }];
}

- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(id<LocationManagerInterface>)theLocationManager forIndex:(int)i
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
            [self appendExperiencesForGroup:(page/3) + 1 new:FALSE];
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
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * ([self.childViewControllers count] + 1), CGRectGetHeight(self.scrollView.frame));
    self.currentViewController = self.childViewControllers[index];
}

- (void)clear
{
    int subviewCount = [[self.scrollView subviews] count];
    
    for (int subviewIndex = 0; subviewIndex < subviewCount; subviewIndex++) {
        [[[self.scrollView subviews] objectAtIndex:0] removeFromSuperview];
        [[self.childViewControllers objectAtIndex:0] removeFromParentViewController];
    }
}

- (void)experienceWasCreated
{
    [self clear];
    [self appendExperiencesForGroup:1 new:TRUE];
}

- (void)showNewExperience
{
    // Switch tab controller
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabBarController setSelectedIndex:0];
    
    CGPoint firstScreen = {0, 0};
    // Show first screen
    [self.scrollView setContentOffset:firstScreen];
    
}

@end
