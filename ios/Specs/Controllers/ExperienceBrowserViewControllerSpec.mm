#import "ExperienceBrowserViewController.h"
#import "FakeExperienceRepository.h"
#import "Experience.h"
#import "ExperienceViewController.h"

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

    context(@"when the request for an experience returns", ^{
        beforeEach(^{
            repository.successBlock(experience);
            [controller.currentExperienceViewController.view setNeedsDisplay];
        });
        
        it(@"shows an experience", ^{
            controller.currentExperienceViewController.taglineLabel.text should equal(@"Run the Lyon Street stairs");
        });
        
        it(@"adds the experience view as a subview of the scroll view", ^{
            [controller.scrollView.subviews objectAtIndex:0] should equal(controller.currentExperienceViewController.view);
        });
    });
});

SPEC_END
