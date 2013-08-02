#import <Foundation/Foundation.h>

@interface ImageRepository : NSObject

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSURL *))successBlock;

@end
