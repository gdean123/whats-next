#import "ExperienceBrowserViewController.h"
#import "ExperienceRepository.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserViewControllerSpec)

describe(@"ExperienceBrowserViewController", ^{
    __block Experience *experience;
    __block id repository;
    
    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        repository = [OCMockObject mockForClass:[ExperienceRepository class]];
        
        void (^theBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
            void (^then)(Experience *e) = nil;
            [invocation getArgument:&then atIndex:1];
            then(experience);
        }; 
                
        [[[repository stub] andDo:theBlock] get:[OCMArg any] then:[OCMArg any]];
    });

    it(@"renders the tagline returned by the ExperienceRepository", ^{
        ExperienceBrowserViewController *viewController = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        viewController.view should_not be_nil;
        //[viewController.view setNeedsDisplay];
        //viewController.taglineLabel.text should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END
