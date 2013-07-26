#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock
{
    self.group = group;
    self.successBlock = successBlock;
}

- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock
{
    self.lastCreatedExperience = experience;
}

@end
