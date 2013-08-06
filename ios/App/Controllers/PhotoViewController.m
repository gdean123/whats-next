#import "PhotoViewController.h"
#import "ExperienceBuilder.h"
#import "RecommendationNavigationController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (PhotoViewController *)initWithExperienceBuilder:(ExperienceBuilder *)experienceBuilder
{
    self = [super initWithNibName:@"PhotoViewController" bundle:nil];
    if (self) {
        self.experienceBuilder = experienceBuilder;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                              message:@"Device has no camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//        
//        [myAlertView show];
//        
//    }
}

-(IBAction)takePhoto:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.experienceBuilder setImage:image];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    RecommendationNavigationController *parentController = (RecommendationNavigationController *)self.parentViewController;
    [parentController pushViewController:parentController.experienceRecommendationViewController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
