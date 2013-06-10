#import "Model.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface ModelNoOverride : Model

@end

@implementation ModelNoOverride

@end

@interface ModelOverride : Model

@end

@implementation ModelOverride

- (NSDictionary *)serialize
{
    return NULL;
}

- (id)deserialize:(NSDictionary *)attributes
{
    return nil;
}

@end


SPEC_BEGIN(ModelSpec)

describe(@"Model", ^{    
    
    it(@"cannot be initiated", ^{
        
        // The compiler switches turn off 'unused' warning, which I don't how to fix
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
        expect(^{[[Model alloc] init];}).to(raise_exception.with_reason(@"Abstract class Model cannot be initiated"));
#pragma clang diagnostic pop
        
    } );
    
    
});

describe(@"Model subclass", ^{
    __block ModelNoOverride *modelNoOverride;
    __block ModelOverride *modelOvrride;
    
    beforeEach(^{
        modelNoOverride = [[ModelNoOverride alloc] init];
        modelOvrride = [[ModelOverride alloc] init];
    });
    
    it(@"should throw execption when non-implemented serialized is called", ^{
        expect(^{[modelNoOverride serialize];}).to(raise_exception.with_reason(@"serialize is not implemented"));
    });
    
    it(@"should throw execption when non-implemented serialized is called", ^{
        expect(^{[modelNoOverride deserialize:@{@"name": @"Experience"}];}).to(raise_exception.with_reason(@"deserialize is not implemented"));
    });
    
    it(@"should not throw execption when implemented serialized is called", ^{
        [modelOvrride serialize] should be_nil();
    });
    
    it(@"should not throw execption when implemented serialized is called", ^{
        [modelOvrride deserialize:@{@"name": @"Experience"}] should be_nil();
    });
});

SPEC_END
