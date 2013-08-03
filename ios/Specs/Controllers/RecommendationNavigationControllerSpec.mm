#import "RecommendationNavigationController.h"
#import "ExperienceRecommendationViewController.h"
#import "FakeExperienceRepository.h"
#import "FakeImageRepository.h"
#import "FakeLocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecommendationNavigationControllerSpec)

describe(@"RecommendationNavigationController", ^{
    __block RecommendationNavigationController *controller;
    __block FakeLocationManager *locationManager;
    __block FakeExperienceRepository *experienceRepository;
    __block FakeImageRepository *imageRepository;
    
    beforeEach(^{
        locationManager = [[FakeLocationManager alloc] init];
        experienceRepository = [[FakeExperienceRepository alloc] init];
        imageRepository = [[FakeImageRepository alloc] init];
        controller = [[RecommendationNavigationController alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository locationManager:locationManager];
    });
    
    it(@"hides navigation bar", ^{
        controller.navigationBarHidden should be_truthy;
    });
    
    it(@"shows the photo view controller as the top view controller", ^{
        controller.topViewController should be_instance_of([PhotoViewController class]);
    });
});

SPEC_END
