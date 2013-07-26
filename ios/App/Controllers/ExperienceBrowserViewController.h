#import <UIKit/UIKit.h>
#import "ExperienceRepositoryInterface.h"
#import "LocationManager.h"
#import "ExperienceBrowserScrollView.h"

@class ExperienceViewController, SpinnerViewController;

@interface ExperienceBrowserViewController : UIViewController <ExperienceBrowserScrollViewDelegate>

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository;
- (void)scrollViewDidSwipeInDirection:(ScrollDirection)scrollDirection;

@property (strong, nonatomic) UIViewController *currentViewController;
@property (nonatomic, strong) SpinnerViewController *spinnerViewController;
@property (weak, nonatomic) IBOutlet ExperienceBrowserScrollView *scrollView;
@property (nonatomic, strong) LocationManager *locationManager;

@end


