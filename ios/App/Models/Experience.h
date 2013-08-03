#import <Foundation/Foundation.h>
#import "Model.h"
#import <CoreLocation/CoreLocation.h>

@interface Experience : Model

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) NSString *imageUrl;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;

- (Experience *)initWithTagline:(NSString *)theTagline imageUrl:(NSString *)theImageUrl latitude:(double)theLatitude longitude:(double)theLongitude;

@end
