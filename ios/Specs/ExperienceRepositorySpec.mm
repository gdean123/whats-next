#import "ExperienceRepository.h"
#import "Model.h"
#import "Experience.h"
#import "Poller.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceRepositorySpec)

describe(@"ExperienceRepository", ^{
    it(@"can retrieve a saved model", ^{
        ExperienceRepository *repository = [[ExperienceRepository alloc] init];
        Experience *modelToCreate = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        [repository create:modelToCreate];
        
        [Poller waitForCreation:modelToCreate];
        
        __block Experience *experience;

        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        [repository getModel:modelToCreate.dbId
                     success:^( Experience * e){
                         experience = e;
                         
                         // Done waiting
                         dispatch_semaphore_signal(sema);
                     }
                     failure:NULL];
        
        // Wait
        while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) { [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]; }

        experience.tagline should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END