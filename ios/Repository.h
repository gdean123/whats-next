#import <Foundation/Foundation.h>

@class Model;

@interface Repository : NSObject

- (Repository *)initWithModel:(Model *)someModel;
- (void)create;
// return a dictionary of attributes
- (void)retrieve:(int)objectId;

@end

