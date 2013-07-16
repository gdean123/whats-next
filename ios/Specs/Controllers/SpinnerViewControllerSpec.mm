#import "SpinnerViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SpinnerViewControllerSpec)

describe(@"SpinnerViewController", ^{
    __block SpinnerViewController *spinnerViewController;

    beforeEach(^{
        spinnerViewController = [[SpinnerViewController alloc] init];
        [spinnerViewController.view setNeedsDisplay];
    });
    
    it(@"shows spinner", ^{
        [spinnerViewController.spinner isAnimating] should be_truthy;
    });
    
});

SPEC_END
