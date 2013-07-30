#import "RecommendationNavigationController.h"
#import "ExperienceRecommendationViewController.h"
#import "FakeExperienceRepository.h"
#import "FakeLocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecommendationNavigationControllerSpec)

describe(@"RecommendationNavigationController", ^{
    __block RecommendationNavigationController *controller;
    __block FakeLocationManager *locationManager;
    __block FakeExperienceRepository *experienceRepository;
    
    beforeEach(^{
        locationManager = [[FakeLocationManager alloc] init];
        experienceRepository = [[FakeExperienceRepository alloc] init];
        controller = [[RecommendationNavigationController alloc] initWithRepository:experienceRepository locationManager:locationManager];
    });
    
    it(@"hides navigation bar", ^{
        controller.navigationBarHidden should be_truthy;
    });
    
    it(@"shows ExperienceRecommendationViewController as topViewController", ^{
        controller.topViewController should be_instance_of([ExperienceRecommendationViewController class]);
    });
});

SPEC_END
