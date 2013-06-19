#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository

- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock
{
    self.successBlock = successBlock;
}

@end
