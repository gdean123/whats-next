#import "ExperienceViewController.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceViewControllerSpec)

describe(@"ExperienceViewController", ^{
    __block ExperienceViewController *controller;
    __block Experience *experience;
    __block LocationManager *locationManager;
    __block CLLocation *farLocation;
    __block CLLocation *closeLocation;
    
    beforeEach(^{
        experience = [[Experience alloc] initWithTagline:@"Run the Lyon Street stairs" image:nil latitude:37.788319 longitude:-122.40744];

        locationManager = [[LocationManager alloc] init];
        controller = [[ExperienceViewController alloc] initWithExperience:experience locationManager:locationManager];
        farLocation = [[CLLocation alloc] initWithLatitude:37.806207 longitude:-122.423104];
        closeLocation = [[CLLocation alloc] initWithLatitude:37.788000 longitude:-122.40744];
        [controller.view setNeedsDisplay];
    });
    
    it(@"renders the tagline", ^{
        controller.taglineLabel.text should equal(@"Run the Lyon Street stairs");
    });
    
    it(@"renders the distance with one digit after the decimal", ^{
        [locationManager locationManager:nil didUpdateLocations:@[farLocation]];
        
        controller.distanceLabel.text should equal(@"1.5mi");
    });
    
    it(@"renders the distance in feet when less than 0.1 m", ^{
        [locationManager locationManager:nil didUpdateLocations:@[closeLocation]];

        controller.distanceLabel.text should equal(@"116ft");
    });
    
    it(@"only shows location label when location is set", ^{
        controller.distanceLabel.hidden should be_truthy;
        
        [locationManager locationManager:nil didUpdateLocations:@[closeLocation]];
        
        controller.distanceLabel.hidden should_not be_truthy;
    });
});

SPEC_END
