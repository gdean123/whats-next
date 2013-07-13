#import "Experience.h"

@implementation Experience

@synthesize tagline;
@synthesize image;

- (Experience *)initWithTagline:(NSString *)theTagline image:(NSString *)theImage latitude:(double)theLatitude longitude:(double)theLongitude
{
    Experience *experience = [[Experience alloc] init];
    experience.tagline = theTagline;
    experience.image = theImage;
    experience.latitude = theLatitude;
    experience.longitude =  theLongitude;
    return experience;
}

@end
