#import <Foundation/Foundation.h>

@class Experience;

@protocol Repository <NSObject>

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock;

@end
