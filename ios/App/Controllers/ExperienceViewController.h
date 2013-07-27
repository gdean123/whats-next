#import "LocationManager.h"
@class Experience;

@interface ExperienceViewController : UIViewController<LocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (id)initWithExperience:(Experience *)theExperience locationManager:(id<LocationManagerInterface>)theLocationManager;

@end
