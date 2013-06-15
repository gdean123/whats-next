#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Poller.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    it(@"can retrieve a saved model", ^{
        ExperienceRepository *repository = [[ExperienceRepository alloc] init];
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        [repository create:modelToCreate];
        
        [Poller waitForCreation:modelToCreate];
        
        Experience *retrievedModel = [repository getModel:modelToCreate.dbId];
        retrievedModel.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END