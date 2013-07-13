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

    Experience *(^createExperience)(NSString *, NSString *) = ^(NSString *tagline, NSString *image) {
        Experience *modelToCreate = [[Experience alloc] initWithTagline:tagline image:image latitude:37.788319 longitude:-122.40744];
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

    NSArray *(^getAllExperiences)() = ^ () {
        __block NSArray *retrievedExperiences;
        
        [repository getAllThen:^(NSArray *experiences){
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
        
        firstExperience = createExperience(@"Run the Lyon Street stairs", @"first.jpg");
        secondExperience = createExperience(@"Check out a mural in the mission", @"second.jpg");
    });
    
    afterEach(^{
        deleteExperience(firstExperience);
        deleteExperience(secondExperience);
    });
    
    it(@"can retrieve a saved experience", ^{
        Experience *retrievedExperience = getExperienceWithId(firstExperience.dbId);
        retrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
        retrievedExperience.image should equal(@"http://localhost:3000/images/first.jpg");
    });
    
    it(@"can retrieve all experiences", ^{
        NSArray *experiences = getAllExperiences();
        Experience *firstRetrievedExperience = experiences[0];
        Experience *secondRetrievedExperience = experiences[1];
        
        secondRetrievedExperience.tagline should equal(@"Check out a mural in the mission");
        secondRetrievedExperience.image should equal(@"http://localhost:3000/images/second.jpg");
        
        firstRetrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
        firstRetrievedExperience.image should equal(@"http://localhost:3000/images/first.jpg");
    });
});

SPEC_END