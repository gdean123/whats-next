#import <Foundation/Foundation.h>
#import "Model.h"
#import <CoreLocation/CoreLocation.h>

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) NSString *image;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

- (Experience *)initWithTagline:(NSString *)theTagline image:(NSString *)theImage latitude:(double)theLatitude longitude:(double)theLongitude;

@end
