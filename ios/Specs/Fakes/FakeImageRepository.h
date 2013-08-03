#import <Foundation/Foundation.h>
#import "ImageRepositoryInterface.h"

@interface FakeImageRepository : NSObject<ImageRepositoryInterface>

@property (strong, nonatomic) UIImage *lastPhoto;
@property (strong, nonatomic) void (^completeCreateWithUrl)(NSString *url);

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSString *))successBlock;

@end
