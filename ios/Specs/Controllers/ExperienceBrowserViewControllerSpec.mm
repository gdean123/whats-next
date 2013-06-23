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
    __block Experience *firstExperience;
    __block Experience *secondExperience;
    
    beforeEach(^{
        firstExperience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Run the Lyon Street stairs"}];
        secondExperience = [[Experience alloc] initWithDictionary:@{@"tagline": @"Check out the mural in the Mission"}];
        repository = [[FakeExperienceRepository alloc] init];
        controller = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        [controller.view setNeedsDisplay];
    });

    context(@"when the request for an experience returns", ^{
        beforeEach(^{
            repository.successBlock(@[firstExperience, secondExperience]);
            [controller.currentExperienceViewController.view setNeedsDisplay];
        });
        
        fit(@"shows an experience", ^{
            controller.currentExperienceViewController.taglineLabel.text should equal(@"Run the Lyon Street stairs");
        });
        
        it(@"adds the experience view as a subview of the scroll view", ^{
            [controller.scrollView.subviews objectAtIndex:0] should equal(controller.currentExperienceViewController.view);
        });
    });
});

SPEC_END
