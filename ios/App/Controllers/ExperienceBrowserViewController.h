#import <UIKit/UIKit.h>

#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"
#import "ExperienceBrowserScrollView.h"
#import "RecommendationDelegate.h"

@class ExperienceViewController, SpinnerViewController, LocationManager;

@interface ExperienceBrowserViewController : UIViewController <ExperienceBrowserScrollViewDelegate, RecommendationDelegate>

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;
- (void)scrollViewDidSwipeInDirection:(ScrollDirection)scrollDirection;

@property (strong, nonatomic) UIViewController *currentViewController;
@property (nonatomic, strong) SpinnerViewController *spinnerViewController;
@property (weak, nonatomic) IBOutlet ExperienceBrowserScrollView *scrollView;

@end


