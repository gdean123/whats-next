#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository


- (void)getAllThen:(void (^) (NSArray *experiences))successBlock
{
    self.successBlock = successBlock;
}

@end
