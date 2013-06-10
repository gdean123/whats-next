#import "Repository.h"

// private properties
@interface Repository()
@property (strong, nonatomic) Model* model;
@end

@implementation Repository

@synthesize model;

- (Repository *)initWithModel:(Model *)someModel
{
    Repository *repository = [[Repository alloc] init];
    repository.model = someModel;
    return repository;
}

- (int)save
{
    return 0;
}

- (NSDictionary *)retrieve:(int)objectId
{
    // hardcoded a value here and shoule be replaced with real implementation.
    return @{@"name": @"Experience"};
}

@end
