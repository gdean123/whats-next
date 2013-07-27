#import "FakeExperienceRepository.h"

@implementation FakeExperienceRepository

- (void)getGroup:(int)group near:(CLLocation *)location then:(void (^) (NSArray *experiences))successBlock
{
    self.lastGroup = group;
    self.lastLocation = location;
    self.completeFetchForGroup = successBlock;
}

- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock
{
    self.lastCreatedExperience = experience;
    self.completeCreate = successBlock;
}

@end
