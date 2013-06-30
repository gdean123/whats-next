#import "Experience.h"

@implementation Experience

@synthesize tagline;
@synthesize image;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary
{
    Experience *experience = [[Experience alloc] init];
    experience.tagline = experienceDictionary[@"tagline"];
    experience.image = experienceDictionary[@"image"];
    experience.latitude = experienceDictionary[@"latitude"];
    experience.longitude =  experienceDictionary[@"longitude"];
    return experience;
}

@end
