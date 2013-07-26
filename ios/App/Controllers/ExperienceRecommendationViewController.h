#import <UIKit/UIKit.h>
#import "LocationManagerInterface.h"
#import "ExperienceRepositoryInterface.h"

@interface ExperienceRecommendationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taglineTextField;

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;

@end
