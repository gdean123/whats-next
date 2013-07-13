#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceSpec)

describe(@"Experience", ^{
    __block Experience *experience;

    beforeEach(^{
        experience = [[Experience alloc] initWithTagline:@"Run the Lyon Street stairs"
                                                   image:@"http://localhost:3000/images/parrots.png"
                                                latitude:37.806207
                                               longitude:-122.423104];
    });
    
    it(@"has a tagline attribute", ^{
        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
    
    it(@"has an image attribute", ^{
        experience.image should equal(@"http://localhost:3000/images/parrots.png");
    });
    
    it(@"has a latitude attribute", ^{
        experience.latitude should equal(37.806207);
    });
    
    it(@"has a longitude attribute", ^{
        experience.longitude should equal(-122.423104);
    });
});

SPEC_END
