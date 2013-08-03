#import <UIKit/UIKit.h>

@class ExperienceBuilder;

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) ExperienceBuilder* experienceBuilder;

- (PhotoViewController *)initWithExperienceBuilder:(ExperienceBuilder *)experienceBuilder;
- (IBAction)takePhoto:(UIButton *)sender;

@end
