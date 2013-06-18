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
        experience = [Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        
        repository = [OCMockObject mockForClass:[ExperienceRepository class]];
        [[[repository stub] andReturn:experience] get:@0 then:^(Experience *) {
            
        }];
    });

    it(@"renders the tagline returned by the ExperienceRepository", ^{
        ExperienceBrowserViewController *viewController = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        
        viewController.taglineLabel.text should equal(@"Run the Lyon Street stairs");
    })
});

SPEC_END
