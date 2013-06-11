#import "Model.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ModelSpec)

describe(@"Model", ^{
    __block Model *model;
    
    beforeEach(^{
        model = [[Model alloc] init];
    });
    
    it(@"should throw an exception when serialize is not overridden", ^{
        expect(^{[model serialize];}).to(raise_exception.with_reason(@"serialize is not implemented"));
    });
    
    it(@"should throw an execption when initWithDictionary is not overridden", ^{
        expect(^{(void)[model initWithDictionary:@{@"name": @"Experience"}];}).to(raise_exception.with_reason(@"initWithDictionary is not implemented"));
    });
    
    it(@"should throw an exception when path is not overridden", ^{
        expect(^{(void)[model path];}).to(raise_exception.with_reason(@"path is not implemented"));
    });
});

SPEC_END
