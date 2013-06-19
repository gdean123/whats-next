#import <Foundation/Foundation.h>

@class Experience;

@protocol Repository <NSObject>

- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock;

@end
