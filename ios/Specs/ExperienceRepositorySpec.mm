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
    
    it(@"can retrieve a saved model", ^{
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];

        [repository create:modelToCreate then:^(Experience * e){ [blocker doneWaiting]; }];
        [blocker wait];
        
        __block Experience *retrievedExperience;
        
        [repository get:modelToCreate.dbId
                   then:^(Experience * e){
                         retrievedExperience = e;
                         [blocker doneWaiting];
                     }];
        
        [blocker wait];

        retrievedExperience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END