#import <Foundation/Foundation.h>

@class Experience;

@protocol Repository <NSObject>

- (void)getPage:(int)page then:(void (^) (NSArray *experiences))successBlock;

@end
