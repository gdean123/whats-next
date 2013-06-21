#import "ExperienceViewController.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceViewControllerSpec)

describe(@"ExperienceViewController", ^{
    __block ExperienceViewController *controller;
    __block Experience *experience;
    
    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        controller = [[ExperienceViewController alloc] initWithExperience:experience];
    });
    
    it(@"displays a tagline", ^{
        controller.taglinelabel.text should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END
