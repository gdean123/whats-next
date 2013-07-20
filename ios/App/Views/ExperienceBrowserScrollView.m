#import "ExperienceBrowserScrollView.h"

@implementation ExperienceBrowserScrollView

@synthesize experienceBrowserScrollViewDelegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.delegate = self;
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
    }
    return self;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    ScrollDirection scrollDirection = ScrollDirectionUnknown;

    if (self.lastContentOffset > scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionLeft;
    else if (self.lastContentOffset < scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionRight;
    
    self.lastContentOffset = scrollView.contentOffset.x;

    [self.experienceBrowserScrollViewDelegate scrollViewDidSwipeInDirection:scrollDirection];
}

@end
