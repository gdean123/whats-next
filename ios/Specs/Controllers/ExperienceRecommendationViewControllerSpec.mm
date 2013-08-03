#import "ExperienceRecommendationViewController.h"
#import "ExperienceBuilder.h"
#import "FakeExperienceRepository.h"
#import "FakeLocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRecommendationViewControllerSpec)

describe(@"ExperienceRecommendationViewController", ^{
    __block FakeExperienceRepository *repository;
    __block FakeLocationManager *locationManager;
    __block ExperienceBuilder *builder;
    __block ExperienceRecommendationViewController *controller;

    beforeEach(^{
        repository = [[FakeExperienceRepository alloc] init];
        locationManager = [[FakeLocationManager alloc] initWithLatitude:123 longitude:456];
        builder = [[ExperienceBuilder alloc] initWithRepository:repository locationManager:locationManager];
        controller = [[ExperienceRecommendationViewController alloc] initWithExperienceBuilder:builder];

        [controller.view setNeedsDisplay];
    });
    
    void(^createExperience)() = ^() {
        controller.taglineTextField.text = @"Run the Lyon Street stairs";
        [controller textFieldShouldReturn:controller.taglineTextField];
    };
    
    it(@"creates a new experience at the current location", ^{
        createExperience();
        repository.lastCreatedExperience.tagline should equal(@"Run the Lyon Street stairs");
        repository.lastCreatedExperience.latitude should equal(123);
        repository.lastCreatedExperience.longitude should equal(456);
    });
    
    it(@"notifies its delegate when a new experience is created", ^{
        id mockRecommendationDelegate = [OCMockObject mockForProtocol:@protocol(RecommendationDelegate)];
        controller.delegate = mockRecommendationDelegate;
        [[mockRecommendationDelegate expect] experienceWasCreated];
        
        createExperience();
        repository.completeCreate(nil);
        [mockRecommendationDelegate verify];
    });
});

SPEC_END
