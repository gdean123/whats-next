#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository

- (void)getPage:(int)page then:(void (^) (NSArray *experiences))successBlock
{
    self.successBlock = successBlock;
}

@end
