#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock
{
    self.group = group;
    self.successBlock = successBlock;
}

@end
