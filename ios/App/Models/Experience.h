#import <Foundation/Foundation.h>

@interface Experience : NSObject

@property (strong, nonatomic) NSString *tagline;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
