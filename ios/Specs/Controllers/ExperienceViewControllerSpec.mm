#import "ExperienceViewController.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceViewControllerSpec)

describe(@"ExperienceViewController", ^{
    __block ExperienceViewController *controller;
    __block Experience *experience;
    __block LocationManager *locationManager;
    
    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:
                      @{
                          @"tagline": @"Run the Lyon Street stairs",
                          @"latitude": @37.806207,
                          @"longitude": @-122.423104
                      }];

        locationManager = [[LocationManager alloc] init];
        locationManager.currentLocation = [[CLLocation alloc] initWithLatitude:37.788319 longitude:-122.40744];

        controller = [[ExperienceViewController alloc] initWithExperience:experience locationManager:locationManager];
        [controller.view setNeedsDisplay];
    });
    
    it(@"renders the tagline", ^{
        controller.taglineLabel.text should equal(@"Run the Lyon Street stairs");
    });
    
    it(@"renders the distance with one digit after the decimal", ^{
        controller.distanceLabel.text should equal(@"1.5mi");
    });
});

SPEC_END
