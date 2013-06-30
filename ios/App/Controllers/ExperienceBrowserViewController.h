#import <UIKit/UIKit.h>
#import "Repository.h"
#import "LocationManager.h"

@class ExperienceRepository, ExperienceViewController;

@interface ExperienceBrowserViewController : UIViewController <UIScrollViewDelegate>

- (id)initWithRepository:(id<Repository>)repository;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@property (strong, nonatomic) ExperienceViewController *currentExperienceViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) LocationManager *locationManager;

@end


