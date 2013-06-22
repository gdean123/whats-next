#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    __block ExperienceRepository *repository;
    __block Blocker *blocker;
    __block Experience *firstExperience;
    __block Experience *secondExperience;

    Experience *(^createExperienceWithTagline)(NSString *) = ^(NSString *tagline) {
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": tagline}];
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
    
    beforeEach(^{
        repository = [[ExperienceRepository alloc] init];
        blocker = [[Blocker alloc] init];
        
        firstExperience = createExperienceWithTagline(@"Run the Lyon Street stairs");
        secondExperience = createExperienceWithTagline(@"Check out a mural in the mission");
    });
    
    afterEach(^{
        deleteExperience(firstExperience);
        deleteExperience(secondExperience);
    });
    
    it(@"can retrieve a saved experience", ^{
        Experience *retrievedExperience = getExperienceWithId(firstExperience.dbId);
        retrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
    });
    
    it(@"can retrieve all experiences", ^{
        NSArray *experiences = getAllExperiences();
        Experience *firstRetrievedExperience = experiences[0];
        Experience *secondRetrievedExperience = experiences[1];
        
        secondRetrievedExperience.tagline should equal(@"Check out a mural in the mission");
        firstRetrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END