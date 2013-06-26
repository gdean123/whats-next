#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{
    __block Experience *experience;

    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs", @"image": @"http://localhost:3000/images/parrots.png"}];
    });
    
    it(@"has a tagline attribute", ^{
        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
    
    it(@"has a image attribute", ^{
        experience.image should equal(@"http://localhost:3000/images/parrots.png");
    });
});

SPEC_END
