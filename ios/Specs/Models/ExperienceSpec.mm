#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{
    __block Experience *experience;

    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
    });
    
    it(@"has a tagline attribute", ^{
        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END
