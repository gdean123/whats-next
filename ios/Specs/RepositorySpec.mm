#import "Repository.h"
#import "Model.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface FakeModel : Model

@property (strong, nonatomic) NSString *name;

- (NSDictionary *)serialize;
+ (id)deserialize:(NSDictionary *)attributes;

@end

@implementation FakeModel
@synthesize name;

- (NSDictionary *)serialize {
    return @{@"name": name};
}

+ (id)deserialize:(NSDictionary *)attributes {
    FakeModel *fakeModel = [[FakeModel alloc] init];
    fakeModel.name = attributes[@"name"];
    return fakeModel;
}

@end

SPEC_BEGIN(RepositorySpec)

describe(@"Repository", ^{
    __block Repository *repository;
    __block FakeModel *fakeModel;

    beforeEach(^{
        fakeModel = [[FakeModel alloc] init];
        fakeModel.name = @"Experience";
        repository = [[Repository alloc] initWithModel:fakeModel];
        
    });
    
    it(@"can retrieve a saved model", ^{
        int objectId = [repository save];
        FakeModel *retrievedModel = [FakeModel deserialize:[repository retrieve:objectId]];
        retrievedModel.name should equal(@"Experience");        
    });
});

SPEC_END