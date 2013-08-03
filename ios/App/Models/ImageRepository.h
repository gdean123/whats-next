#import <Foundation/Foundation.h>
#import "ImageRepositoryInterface.h"

@interface ImageRepository : NSObject<ImageRepositoryInterface>

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSString *))successBlock;

@end
