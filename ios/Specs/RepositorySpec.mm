#import "Repository.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RepositorySpec)

describe(@"Repository", ^{
    __block Repository *repository;

    beforeEach(^{
        repository = [[Repository alloc] init];
    });
    
    it(@"can retrieve a saved model", ^{
        // Save a model with an attribute (returns an id?)
        // Retrieve the model
        // Assert that the attribute is the same
    });
});

SPEC_END