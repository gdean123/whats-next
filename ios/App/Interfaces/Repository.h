#import <Foundation/Foundation.h>

@class Experience;

@protocol Repository <NSObject>

- (void)getAllThen:(void (^) (NSArray *experiences))successBlock;

@end
