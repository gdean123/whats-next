#import "Experience.h"

@implementation Experience

- (Experience *)initWithTagline:(NSString *)theTagline imageUrl:(NSString *)theImageUrl latitude:(double)theLatitude longitude:(double)theLongitude
{
    Experience *experience = [[Experience alloc] init];

    if (experience) {
        experience.tagline = theTagline;
        experience.imageUrl = theImageUrl;
        experience.latitude = theLatitude;
        experience.longitude =  theLongitude;
    }
    
    return experience;
}

@end
