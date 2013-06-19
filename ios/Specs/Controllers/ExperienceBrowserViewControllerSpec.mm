#import "ExperienceBrowserViewController.h"
#import "FakeExperienceRepository.h"
#import "Experience.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserViewControllerSpec)

describe(@"ExperienceBrowserViewController", ^{
    __block ExperienceBrowserViewController *controller;
    __block FakeExperienceRepository *repository;
    __block Experience *experience;
    
    beforeEach(^{
        experience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        repository = [[FakeExperienceRepository alloc] init];
        controller = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        [controller.view setNeedsDisplay];
    });

    it(@"renders the tagline returned by the ExperienceRepository", ^{
        repository.successBlock(experience);
        controller.taglineLabel.text should equal(@"Run the Lyon Street stairs");
    });
});

SPEC_END
