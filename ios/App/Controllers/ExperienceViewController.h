@class Experience;

@interface ExperienceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithExperience:(Experience *)experience;

@end
