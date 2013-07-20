#import <UIKit/UIKit.h>

typedef enum ScrollDirection {
    ScrollDirectionUnknown,
    ScrollDirectionRight,
    ScrollDirectionLeft
} ScrollDirection;

@protocol ExperienceBrowserScrollViewDelegate
- (void)scrollViewDidSwipeInDirection:(ScrollDirection)scrollDirection;
@end

@interface ExperienceBrowserScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger lastContentOffsetX;
@property (nonatomic, assign) id<ExperienceBrowserScrollViewDelegate> experienceBrowserScrollViewDelegate;

@end