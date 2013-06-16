#import "Poller.h"
#import "Model.h"

@implementation Poller

+ (void)waitForCreation:(Model *)modelToCreate
{
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && modelToCreate.dbId == NULL){
        NSLog(@"Waiting for model creation");
        sleep(1);
    };
}

+ (void)waitForGet:(Model *)modelToGet
{
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && modelToGet.dbId == NULL){
        NSLog(@"Waiting for model get");
        sleep(1);
    };
}

@end