#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

- (void)appendExperiencesForPage:(int)page;
- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)manager forIndex:(int)i;
- (void)appendExperiences:(NSArray *)experiences startingAtIndex:(int)index;
@property (nonatomic, strong) id<Repository> experienceRepository;

@end

@implementation ExperienceBrowserViewController

@synthesize locationManager;

- (id)initWithRepository:(id<Repository>)repository
{
    self = [super initWithNibName:@"ExperienceBrowserViewController" bundle:nil];
    if (self) {
        self.experienceRepository = repository;
        self.locationManager = [[LocationManager alloc] init];        
        self.spinnerViewController = [[SpinnerViewController alloc] init];       
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    
    [self addSpinner];
    [self appendExperiencesForPage:1];
}

- (void)appendExperiencesForPage:(int)page
{    
    [self.experienceRepository getPage:page then:^(NSArray *experiences) {
        if (!experiences || [experiences count] == 0) return;
        
        [self removeSpinner];
        [self appendExperiences:experiences startingAtIndex:(3 * (page - 1))];
        [self addSpinner];
    }];
}

- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)theLocationManager forIndex:(int)i
{
    ExperienceViewController *experienceViewController = [[ExperienceViewController alloc] initWithExperience:experience locationManager:theLocationManager];
    
    [self addChild:experienceViewController atScreen:i];
    
    return experienceViewController;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    self.currentViewController = self.childViewControllers[page];
    if (page == 3){
        [self appendExperiencesForPage:2];
    }
}

- (void)addChild:(UIViewController *)child atScreen:(int)screen
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = CGRectGetWidth(frame) * screen;
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
    [self addChild:self.spinnerViewController atScreen:[self.childViewControllers count]];
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
