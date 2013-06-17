#import "ExperienceBrowserViewController.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserViewControllerSpec)

describe(@"ExperienceBrowserViewController", ^{
    it(@"renders the tagline returned by the ExperienceRepository", ^{
        Experience *experience = [Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        
        ExperienceBrowserViewController *viewController = [[ExperienceBrowserViewController alloc] initWithExperiences:@[experience]];
        
        taglineLabel.text should equal(@"Run the Lyon Street stairs");
    })
});

SPEC_END
