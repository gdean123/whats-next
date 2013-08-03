#import "ExperienceBuilder.h"
#import "FakeExperienceRepository.h"
#import "FakeLocationManager.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBuilderSpec)

describe(@"ExperienceBuilder", ^{
    __block ExperienceBuilder *experienceBuilder;
    __block FakeExperienceRepository *experienceRepository;
    __block FakeLocationManager *locationManager;
    __block Blocker *blocker;
    
    beforeEach(^{
        experienceRepository = [[FakeExperienceRepository alloc] init];
        locationManager = [[FakeLocationManager alloc] initWithLatitude:123 longitude:456];
        blocker = [[Blocker alloc] init];
        
        experienceBuilder = [[ExperienceBuilder alloc] initWithRepository:experienceRepository locationManager:locationManager];
    });
    
    it(@"sets the tagline of the created experience", ^{
        experienceBuilder.tagline = @"Run the Lyon Street steps";
        [experienceBuilder createThen:^(Experience *) {}];
        experienceRepository.lastCreatedExperience.tagline should equal(@"Run the Lyon Street steps");
    });
    
    it(@"sets the location of the created experience", ^{
        [experienceBuilder createThen:^(Experience *) {}];
        experienceRepository.lastCreatedExperience.latitude should equal(123);
        experienceRepository.lastCreatedExperience.longitude should equal(456);
    });
});

SPEC_END
