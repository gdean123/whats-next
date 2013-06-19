#import <UIKit/UIKit.h>
#import "Repository.h"

@class ExperienceRepository;

@interface ExperienceBrowserViewController : UIViewController

- (id)initWithRepository:(id<Repository>)repository;

@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@end
