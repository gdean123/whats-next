#import "Poller.h"
#import "Model.h"

@interface Poller()

@property (strong, nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation Poller

- (Poller *) init
{
    self = [super init];
    
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    
    return self;
}

+ (void)waitForCreation:(Model *)modelToCreate
{
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && modelToCreate.dbId == NULL){
        NSLog(@"Waiting for model creation");
        sleep(1);
    };
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