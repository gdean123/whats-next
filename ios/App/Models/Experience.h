#import <Foundation/Foundation.h>
#import "Model.h"

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
