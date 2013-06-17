#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    __block Blocker *blocker;
    
    beforeEach(^{
        blocker = [[Blocker alloc] init];
    });
    
    it(@"can retrieve a saved model", ^{
        ExperienceRepository *repository = [[ExperienceRepository alloc] init];
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];

        [repository create:modelToCreate then:^(Experience * e){
            [blocker doneWaiting];
        }];
        [blocker wait];
        
        __block Experience *experience;
        
        [repository get:modelToCreate.dbId
                   then:^(Experience * e){
                         experience = e;
                         [blocker doneWaiting];
                     }];
        
        [blocker wait];

        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END