#import "Model.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ModelSpec)

describe(@"Model", ^{
    __block Model *model;
    
    beforeEach(^{
        model = [[Model alloc] init];
    });
    
    it(@"should throw an exception when path is not overridden", ^{
        expect(^{(void)[model path];}).to(raise_exception.with_reason(@"path is not implemented"));
    });
    
    it(@"starts with an NULL dbId", ^{
        expect(model.dbId).to(equal(NULL));
    });
});

SPEC_END
