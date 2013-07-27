#import <UIKit/UIKit.h>
#import "LocationManagerInterface.h"
#import "ExperienceRepositoryInterface.h"
#import "RecommendationDelegate.h"

@interface ExperienceRecommendationViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *taglineTextField;
@property (nonatomic, assign) id<RecommendationDelegate> delegate;

- (id)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;

@end
