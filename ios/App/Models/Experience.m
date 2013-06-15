#import "Experience.h"

@implementation Experience

@synthesize tagline;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary
{
    Experience *experience = [[Experience alloc] init];
    experience.tagline = experienceDictionary[@"tagline"];
    return experience;
}

@end
