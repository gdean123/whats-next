#import "SpinnerViewController.h"

@interface SpinnerViewController ()

@end

@implementation SpinnerViewController

- (id)init
{
    self = [super initWithNibName:@"SpinnerViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.spinner startAnimating];
}

@end
