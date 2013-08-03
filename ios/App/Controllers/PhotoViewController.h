#import <UIKit/UIKit.h>

@class ExperienceBuilder;

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) ExperienceBuilder* experienceBuilder;

- (PhotoViewController *)initWithExperienceBuilder:(ExperienceBuilder *)experienceBuilder;
- (IBAction)takePhoto:(UIButton *)sender;

@end
