#import <Foundation/Foundation.h>
#import "Model.h"

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) NSString *image;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
