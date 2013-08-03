#import "PhotoViewController.h"
#import "ExperienceBuilder.h"
#import "FakeExperienceRepository.h"
#import "FakeLocationManager.h"
#import "FakeImageRepository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PhotoViewControllerSpec)

describe(@"PhotoViewController", ^{
    __block PhotoViewController *controller;
    __block FakeExperienceRepository *experienceRepository;
    __block FakeImageRepository *imageRepository;
    __block FakeLocationManager *locationManager;
    __block ExperienceBuilder *experienceBuilder;
    
    beforeEach(^{
        experienceRepository = [[FakeExperienceRepository alloc] init];
        locationManager = [[FakeLocationManager alloc] initWithLatitude:123 longitude:456];
        imageRepository = [[FakeImageRepository alloc] init];
        experienceBuilder = [[ExperienceBuilder alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository locationManager:locationManager];
        controller = [[PhotoViewController alloc] initWithExperienceBuilder:experienceBuilder];
    });
    
    void (^takePhoto)(UIImage *) = ^(UIImage *image)
    {
        [controller imagePickerController:controller.imagePicker didFinishPickingMediaWithInfo:@{
            UIImagePickerControllerOriginalImage: image
         }];
    };
    
    bool (^isImageEqual)(UIImage *, UIImage *) = ^(UIImage *image1, UIImage *image2)
    {
        return UIImagePNGRepresentation(image1) == UIImagePNGRepresentation(image2);
    };
    
    it(@"sets the image on the experience builder when a photo is taken", ^{
        UIImage *image = [UIImage imageNamed:@"new_photo"];
        takePhoto(image);
        isImageEqual(imageRepository.lastPhoto, image) should be_truthy;
    });
});

SPEC_END
