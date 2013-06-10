#import <Foundation/Foundation.h>

@class Model;

@interface Repository : NSObject

- (Repository *)initWithModel:(Model *)someModel;
- (int)save;
// return a dictionary of attributes
- (NSDictionary *)retrieve:(int)objectId;

@end

