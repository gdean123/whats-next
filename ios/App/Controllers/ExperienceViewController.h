@class Experience;

@interface ExperienceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

- (id)initWithExperience:(Experience *)experience;

@end
