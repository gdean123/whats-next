#import <UIKit/UIKit.h>
#import "Repository.h"

@class ExperienceRepository, ExperienceViewController;

@interface ExperienceBrowserViewController : UIViewController <UIScrollViewDelegate>

- (id)initWithRepository:(id<Repository>)repository;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@property (strong, nonatomic) ExperienceViewController *currentExperienceViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end


