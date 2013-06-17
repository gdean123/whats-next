#import <Foundation/Foundation.h>

@interface Blocker : NSObject

- (Blocker *)init;
- (void)wait;
- (void)doneWaiting;

@end
