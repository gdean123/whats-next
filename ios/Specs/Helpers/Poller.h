#import <Foundation/Foundation.h>

@class Model;

@interface Poller : NSObject

+ (void)waitForCreation:(Model *)modelToCreate;

- (Poller *) init;
- (void)wait;
- (void)doneWaiting;

@end
