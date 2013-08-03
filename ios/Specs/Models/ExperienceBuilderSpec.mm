#import "ExperienceBuilder.h"
#import "FakeExperienceRepository.h"
#import "FakeImageRepository.h"
#import "FakeLocationManager.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBuilderSpec)

describe(@"ExperienceBuilder", ^{
    __block ExperienceBuilder *experienceBuilder;
    __block FakeExperienceRepository *experienceRepository;
    __block FakeImageRepository *imageRepository;
    __block FakeLocationManager *locationManager;
    __block Blocker *blocker;

    beforeEach(^{
        experienceRepository = [[FakeExperienceRepository alloc] init];
        imageRepository = [[FakeImageRepository alloc] init];
        locationManager = [[FakeLocationManager alloc] initWithLatitude:123 longitude:456];
        blocker = [[Blocker alloc] init];
        
        experienceBuilder = [[ExperienceBuilder alloc] initWithExperienceRepository:experienceRepository imageRepository:imageRepository locationManager:locationManager];
    });
    
    it(@"sets the tagline of the created experience", ^{
        [experienceBuilder setTagline:@"Run the Lyon Street steps"];
        [experienceBuilder createThen:^(Experience *) {}];
        imageRepository.completeCreateWithUrl(nil);
        experienceRepository.lastCreatedExperience.tagline should equal(@"Run the Lyon Street steps");
    });
    
    it(@"sets the location of the created experience", ^{
        [experienceBuilder createThen:^(Experience *) {}];
        imageRepository.completeCreateWithUrl(nil);
        experienceRepository.lastCreatedExperience.latitude should equal(123);
        experienceRepository.lastCreatedExperience.longitude should equal(456);
    });

    it(@"sets the image URL returned by the image repository", ^{
        UIImage *image = [UIImage imageNamed:@"new_photo"];
        [experienceBuilder setImage:image];

        [experienceBuilder createThen:^(Experience *experience) {
            experienceRepository.completeCreate(experience);
        }];
        
        imageRepository.completeCreateWithUrl(@"http://some-url.com");
        experienceRepository.lastCreatedExperience.imageUrl should equal(@"http://some-url.com");
    });
});

SPEC_END
