#import <UIKit/UIKit.h>
#import "Repository.h"
#import "LocationManager.h"

@class ExperienceRepository, ExperienceViewController, SpinnerViewController;

@interface ExperienceBrowserViewController : UIViewController <UIScrollViewDelegate>

- (id)initWithRepository:(id<Repository>)repository;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@property (strong, nonatomic) UIViewController *currentViewController;
@property (nonatomic, strong) SpinnerViewController *spinnerViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) LocationManager *locationManager;

@end


