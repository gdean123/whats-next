#import "RecommendationNavigationController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecommendationNavigationControllerSpec)

describe(@"RecommendationNavigationController", ^{
    __block RecommendationNavigationController *controller;

    beforeEach(^{
        controller = [[RecommendationNavigationController alloc] init];        
    });
    
    it(@"hides navigation bar", ^{
        controller.navigationBarHidden should be_truthy;
    });
});

SPEC_END
