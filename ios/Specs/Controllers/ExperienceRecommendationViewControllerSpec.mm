#import "ExperienceRecommendationViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRecommendationViewControllerSpec)

describe(@"ExperienceRecommendationViewController", ^{
    __block ExperienceRecommendationViewController *experienceRecommendationViewController;

    beforeEach(^{
        experienceRecommendationViewController = [[ExperienceRecommendationViewController alloc] init];
        [experienceRecommendationViewController.view setNeedsDisplay];
    });
    
    xit(@"shows the keyboard immediately", ^{
        spy_on(experienceRecommendationViewController.taglineTextField);
        
        [experienceRecommendationViewController viewDidAppear:NO];
        
        experienceRecommendationViewController.taglineTextField should have_received(@selector(becomeFirstResponder));
    });
});

SPEC_END
