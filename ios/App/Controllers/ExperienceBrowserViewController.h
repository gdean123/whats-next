#import <UIKit/UIKit.h>
#import "Repository.h"
#import "LocationManager.h"
#import "ExperienceBrowserScrollView.h"

@class ExperienceRepository, ExperienceViewController, SpinnerViewController;

@interface ExperienceBrowserViewController : UIViewController <ExperienceBrowserScrollViewDelegate>

- (id)initWithRepository:(id<Repository>)repository;
- (void)scrollViewDidSwipeInDirection:(ScrollDirection)scrollDirection;

@property (strong, nonatomic) UIViewController *currentViewController;
@property (nonatomic, strong) SpinnerViewController *spinnerViewController;
@property (weak, nonatomic) IBOutlet ExperienceBrowserScrollView *scrollView;
@property (nonatomic, strong) LocationManager *locationManager;

@end


