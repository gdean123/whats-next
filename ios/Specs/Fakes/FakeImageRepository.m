#import "FakeImageRepository.h"

@implementation FakeImageRepository

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSString *))successBlock
{
    self.completeCreateWithUrl = successBlock;
}

@end
