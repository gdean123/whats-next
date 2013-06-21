#import <UIKit/UIKit.h>
#import "Repository.h"

@class ExperienceRepository, ExperienceViewController;

@interface ExperienceBrowserViewController : UIViewController

- (id)initWithRepository:(id<Repository>)repository;

@property (weak, nonatomic) ExperienceViewController *currentExperienceViewController;

@end


