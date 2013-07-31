#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
-(IBAction)takePhoto:(UIButton *)sender;

@end
