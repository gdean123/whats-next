#import <UIKit/UIKit.h>
#import "Repository.h"

@class ExperienceRepository, ExperienceViewController;

@interface ExperienceBrowserViewController : UIViewController

- (id)initWithRepository:(id<Repository>)repository;

@property (strong, nonatomic) ExperienceViewController *currentExperienceViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end


