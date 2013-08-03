#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Blocker.h"
#import "DatabaseCleaner.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    __block ExperienceRepository *repository;
    __block Blocker *blocker;
    __block Experience *firstExperience;
    __block Experience *secondExperience;
    __block Experience *thirdExperience;
    __block Experience *fourthExperience;

    Experience *(^createExperience)(NSString *, NSString *, double, double) = ^(NSString *tagline, NSString *imageUrl, double latitude, double longitude) {
        Experience *modelToCreate = [[Experience alloc] initWithTagline:tagline imageUrl:imageUrl latitude:latitude longitude:longitude];
        [repository create:modelToCreate then:^(Experience * e){ [blocker doneWaiting]; }];
        [blocker wait];
        
        return modelToCreate;
    };

    Experience *(^getExperienceWithId)(NSNumber *) = ^(NSNumber *dbId) {
        __block Experience *retrievedExperience;
        
        [repository get:dbId
                   then:^(Experience * e){
                       retrievedExperience = e;
                       [blocker doneWaiting];
                   }];
        
        [blocker wait];
        return retrievedExperience;
    };

    NSArray *(^getExperiencesForGroup)(int) = ^(int group) {
        __block NSArray *retrievedExperiences;
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:37.788000 longitude:-122.40744];
        
        [repository getGroup:group near:location then:^(NSArray *experiences){
                       retrievedExperiences = experiences;
                       [blocker doneWaiting];
                   }];
        
        [blocker wait];
        return retrievedExperiences;
    };

    void(^deleteExperience)(Experience *) = ^(Experience *experience) {
        [repository destroy:experience then:^(){ [blocker doneWaiting];} ];
        [blocker wait];
    };
    
    void(^cleanDatabase)() = ^() {
        [DatabaseCleaner cleanThen:^(){ [blocker doneWaiting];} ];
        [blocker wait];
    };
    
    beforeEach(^{
        repository = [[ExperienceRepository alloc] init];
        blocker = [[Blocker alloc] init];
        
        cleanDatabase();
        
        firstExperience = createExperience(@"Run the Lyon Street stairs", @"first.jpg", 37.788000, -122.40744);
        secondExperience = createExperience(@"Check out a mural in the mission", @"second.jpg", 37.788000, -123.40744);
        thirdExperience = createExperience(@"Watch the sunset on the Dumbarton bridge", @"third.jpg", 37.788000, -124.40744);
        fourthExperience = createExperience(@"Visit the Rengstorff House", @"fourth.jpg", 37.788000, -125.40744);
    });
    
    afterEach(^{
        deleteExperience(firstExperience);
        deleteExperience(secondExperience);
    });
    
    it(@"can retrieve a saved experience", ^{
        Experience *retrievedExperience = getExperienceWithId(firstExperience.dbId);
        retrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
        retrievedExperience.imageUrl should equal(@"http://localhost:3001/images/first.jpg");
    });
    
    it(@"can retrieve experiences for group 1", ^{
        NSArray *experiences = getExperiencesForGroup(1);
        Experience *firstRetrievedExperience = experiences[0];
        Experience *secondRetrievedExperience = experiences[1];
        Experience *thirdRetrievedExperience = experiences[2];
        
        [experiences count] should equal(3);
        
        secondRetrievedExperience.tagline should equal(@"Check out a mural in the mission");
        secondRetrievedExperience.imageUrl should equal(@"http://localhost:3001/images/second.jpg");
        
        thirdRetrievedExperience.tagline should equal(@"Watch the sunset on the Dumbarton bridge");
        thirdRetrievedExperience.imageUrl should equal(@"http://localhost:3001/images/third.jpg");
        
        firstRetrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
        firstRetrievedExperience.imageUrl should equal(@"http://localhost:3001/images/first.jpg");
    });
    
    it(@"can retrieve experiences for group 2", ^{
        NSArray *experiences = getExperiencesForGroup(2);
        Experience *firstRetrievedExperience = experiences[0];
        
        [experiences count] should equal(1);
        
        firstRetrievedExperience.tagline should equal(@"Visit the Rengstorff House");
        firstRetrievedExperience.imageUrl should equal(@"http://localhost:3001/images/fourth.jpg");
    });
    
    it(@"retrieves no experiences for page after last group", ^{
        NSArray *experiences = getExperiencesForGroup(3);
        [experiences count] should equal(0);
    });
});

SPEC_END