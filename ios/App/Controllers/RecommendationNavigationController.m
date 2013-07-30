#import "RecommendationNavigationController.h"

@interface RecommendationNavigationController ()

@end

@implementation RecommendationNavigationController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
         self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
         [self setNavigationBarHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end
