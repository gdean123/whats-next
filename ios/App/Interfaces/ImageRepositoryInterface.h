#import <Foundation/Foundation.h>

@protocol ImageRepositoryInterface <NSObject>

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSString *))successBlock;

@end
