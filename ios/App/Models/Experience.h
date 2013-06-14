#import <Foundation/Foundation.h>
#import "Model.h"

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;

@property (copy, nonatomic) NSNumber *dbId;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
