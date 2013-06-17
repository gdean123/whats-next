#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Poller.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    __block Poller *poller;
    
    beforeEach(^{
        poller = [[Poller alloc] init];
    });
    
    it(@"can retrieve a saved model", ^{
        ExperienceRepository *repository = [[ExperienceRepository alloc] init];
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        [repository create:modelToCreate];
        
        [Poller waitForCreation:modelToCreate];
        
        __block Experience *experience;
        
        [repository getModel:modelToCreate.dbId
                     success:^(Experience * e){
                         experience = e;
                         [poller doneWaiting];
                     }
                     failure:NULL];
        
        [poller wait];

        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END