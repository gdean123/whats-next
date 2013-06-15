#import "Poller.h"
#import "Model.h"

@implementation Poller

+ (void)waitForCreation:(Model *)modelToCreate
{
    while (modelToCreate.dbId == NULL) {
        NSLog(@"Waiting for model creation");
        sleep(1);
    }
}

@end

