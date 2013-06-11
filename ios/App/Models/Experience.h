#import <Foundation/Foundation.h>
#import "Model.h"

@interface Experience : Model

@property (strong, nonatomic) NSString *tagline;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
