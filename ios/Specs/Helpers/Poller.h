#import <Foundation/Foundation.h>

@class Model;

@interface Poller : NSObject

+ (void)waitForCreation:(Model *)modelToCreate;

@end
