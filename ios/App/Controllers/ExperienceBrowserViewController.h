#import <UIKit/UIKit.h>

@class ExperienceRepository;

@interface ExperienceBrowserViewController : UIViewController

- (id)initWithRepository:(ExperienceRepository *)repository;

@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@end
