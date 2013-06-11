#import "Repository.h"
#import "Model.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RepositorySpec)

describe(@"Repository", ^{
    it(@"can retrieve a saved model", ^{
        Experience *modelToCreate = [[Experience alloc] init];
        modelToCreate.tagline = @"Run the Lyon Street stairs";
        Repository *createRepository = [[Repository alloc] initWithModel:modelToCreate];
        int objectId = [createRepository save];

        [Poller waitForModel:]
        
        Experience *retrievedModel = [[Experience alloc] init];
        Repository *retrieveRepository = [[Repository alloc] initWithModel:retrievedModel];
        [retrieveRepository retrieve:objectId];
        retrievedModel.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END