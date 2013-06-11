#import <Foundation/Foundation.h>

@interface Model : NSObject

- (NSDictionary *)serialize;
- (id)initWithDictionary:(NSDictionary *)attributes;
- (NSString *)path;

@end
