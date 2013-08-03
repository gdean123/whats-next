#import <UIKit/UIKit.h>
#import "LocationManagerInterface.h"
#import "ExperienceRepositoryInterface.h"
#import "RecommendationDelegate.h"
#import "ExperienceBuilder.h"

@interface ExperienceRecommendationViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *taglineTextField;
@property (nonatomic, assign) id<RecommendationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

-(ExperienceRecommendationViewController *)initWithExperienceBuilder:(ExperienceBuilder *)experienceBuilder;

@end
