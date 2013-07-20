#import "ExperienceBrowserScrollView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserScrollViewSpec)

describe(@"ExperienceBrowserScrollView", ^{
    __block ExperienceBrowserScrollView *experienceBrowserScrollView;
    __block id mockExperienceBrowserScrollViewDelegate;
    
    beforeEach(^{
        experienceBrowserScrollView = [[ExperienceBrowserScrollView alloc] initWithCoder:nil];
        
        mockExperienceBrowserScrollViewDelegate = [OCMockObject mockForProtocol:@protocol(ExperienceBrowserScrollViewDelegate)];

        experienceBrowserScrollView.experienceBrowserScrollViewDelegate = mockExperienceBrowserScrollViewDelegate;
    });
    
    it(@"calls scrollViewDidSwipeInDirection when scrollViewDidEndDecelerating", ^{
        [[mockExperienceBrowserScrollViewDelegate expect] scrollViewDidSwipeInDirection:ScrollDirectionUnknown];
        [experienceBrowserScrollView scrollViewDidEndDecelerating:experienceBrowserScrollView];
        [mockExperienceBrowserScrollViewDelegate verify];
    });
});

SPEC_END
