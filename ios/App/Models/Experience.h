#import <Foundation/Foundation.h>
#import "Model.h"
#import <CoreLocation/CoreLocation.h>

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSDecimalNumber *latitude;
@property (copy, nonatomic) NSDecimalNumber *longitude;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary;

@end
