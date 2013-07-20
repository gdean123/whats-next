#import "ExperienceBrowserScrollView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserScrollViewSpec)

CGFloat const screenWidth = 640;
CGFloat const screenHeight = 1136;

describe(@"ExperienceBrowserScrollView", ^{
    __block ExperienceBrowserScrollView *experienceBrowserScrollView;
    __block id mockExperienceBrowserScrollViewDelegate;
    
    beforeEach(^{
        experienceBrowserScrollView = [[ExperienceBrowserScrollView alloc] initWithCoder:nil];
        experienceBrowserScrollView.frame = CGRectMake(0, 0, screenWidth * 2, screenHeight);
        experienceBrowserScrollView.contentOffset = CGPointZero;

        mockExperienceBrowserScrollViewDelegate = [OCMockObject mockForProtocol:@protocol(ExperienceBrowserScrollViewDelegate)];

        experienceBrowserScrollView.experienceBrowserScrollViewDelegate = mockExperienceBrowserScrollViewDelegate;
    });
    
    it(@"calls scrollViewDidSwipeInDirection when scrollViewDidEndDecelerating", ^{
        [[mockExperienceBrowserScrollViewDelegate expect] scrollViewDidSwipeInDirection:ScrollDirectionUnknown];
        [experienceBrowserScrollView scrollViewDidEndDecelerating:experienceBrowserScrollView];
        [mockExperienceBrowserScrollViewDelegate verify];
    });
    
    it(@"tells the delegate when we have swiped right", ^{
        [[mockExperienceBrowserScrollViewDelegate expect] scrollViewDidSwipeInDirection:ScrollDirectionRight];
        experienceBrowserScrollView.lastContentOffsetX = 0;
        [experienceBrowserScrollView setContentOffset:CGPointMake(screenWidth, 0)];
        
        [experienceBrowserScrollView scrollViewDidEndDecelerating:experienceBrowserScrollView];
        [mockExperienceBrowserScrollViewDelegate verify];
    });
    
    it(@"tells the delegate when we have swiped left", ^{
        [[mockExperienceBrowserScrollViewDelegate expect] scrollViewDidSwipeInDirection:ScrollDirectionLeft];
        experienceBrowserScrollView.lastContentOffsetX = screenWidth;
        [experienceBrowserScrollView setContentOffset:CGPointZero];
        
        [experienceBrowserScrollView scrollViewDidEndDecelerating:experienceBrowserScrollView];
        [mockExperienceBrowserScrollViewDelegate verify];
    });
});

SPEC_END
