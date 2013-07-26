#import "ExperienceRecommendationViewController.h"
#import "FakeExperienceRepository.h"
#import "FakeLocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRecommendationViewControllerSpec)

describe(@"ExperienceRecommendationViewController", ^{
    __block FakeExperienceRepository *repository;
    __block FakeLocationManager *locationManager;
    __block ExperienceRecommendationViewController *controller;

    beforeEach(^{
        repository = [[FakeExperienceRepository alloc] init];
        locationManager = [[FakeLocationManager alloc] initWithLatitude:123 longitude:456];
        controller = [[ExperienceRecommendationViewController alloc] initWithRepository:repository locationManager:locationManager];

        [controller.view setNeedsDisplay];
    });
    
    xit(@"shows the keyboard immediately", ^{
        spy_on(controller.taglineTextField);
        [controller viewDidAppear:NO];
        controller.taglineTextField should have_received(@selector(becomeFirstResponder));
    });
    
    it(@"creates a new experience at the current location", ^{
        controller.taglineTextField.text = @"Run the Lyon Street stairs";
        [controller textFieldShouldReturn:controller.taglineTextField];
        repository.lastCreatedExperience.latitude should equal(123);
        repository.lastCreatedExperience.longitude should equal(456);
    });
});

SPEC_END
