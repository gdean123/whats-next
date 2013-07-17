#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"
#import "Experience.h"

@interface ExperienceBrowserViewController ()

- (void)loadExperiences;
- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)manager forIndex:(int)i;

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
        
        self.scrollView.delegate = self;
        
        self.spinnerViewController = [[SpinnerViewController alloc] init];       
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
    
    [self addSpinner];
    [self loadExperiences];
}

- (void)loadExperiences
{    
    [self.experienceRepository getPage:1 then:^(NSArray *experiences) {            

        if (!experiences || [experiences count] == 0) return;
        
        [self removeSpinner];
        
        self.scrollView.contentSize =
        CGSizeMake(CGRectGetWidth(self.scrollView.frame) * ([experiences count] + 1), CGRectGetHeight(self.scrollView.frame));
        
        for (int i = 0; i < [experiences count]; i++) {
            [self createViewControllerForExperience:experiences[i] withLocationManager:self.locationManager forIndex:i];
        }
        
        self.currentViewController = self.childViewControllers[0];
        
        [self addSpinner];
    }];
}

- (ExperienceViewController *)createViewControllerForExperience:(Experience *)experience withLocationManager:(LocationManager *)theLocationManager forIndex:(int)i
{
    ExperienceViewController *experienceViewController = [[ExperienceViewController alloc] initWithExperience:experience locationManager:theLocationManager];
    
    [self addChild:experienceViewController atScreen:i];
    
    return experienceViewController;
}

// Delete this method?
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.currentViewController = self.childViewControllers[page];
}

- (void)addChild:(UIViewController *)child atScreen:(int)screen
{
    [self addChildViewController:child];
    [self.scrollView addSubview:child.view];
    [child didMoveToParentViewController:self];
    CGRect frame = self.scrollView.frame;
    frame.origin.x = CGRectGetWidth(frame) * screen;
    frame.origin.y = 0;
    child.view.frame = frame;
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

@end
