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
    
    beforeEach(^{
        repository = [[ExperienceRepository alloc] init];
        blocker = [[Blocker alloc] init];
    });
    
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
    
    it(@"can retrieve a saved model", ^{
        Experience *createdExperience = createExperienceWithTagline(@"Run the Lyon Street stairs");
        Experience *retrievedExperience = getExperienceWithId(createdExperience.dbId);
        retrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END