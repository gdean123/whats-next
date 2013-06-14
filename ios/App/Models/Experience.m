#import "Experience.h"

@implementation Experience

@synthesize tagline;
@synthesize dbId;

- (Experience *)initWithDictionary:(NSDictionary *)experienceDictionary
{
    Experience *experience = [[Experience alloc] init];
    experience.tagline = experienceDictionary[@"tagline"];
    return experience;
}

@end
