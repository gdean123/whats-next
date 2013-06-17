#import "Blocker.h"
#import "Model.h"

@interface Blocker()

@property (strong, nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation Blocker

- (Blocker *)init
{
    self = [super init];
    
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}

- (void)wait
{
    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW)) { [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]; }
}

- (void)doneWaiting
{
    dispatch_semaphore_signal(self.semaphore);
}

@end