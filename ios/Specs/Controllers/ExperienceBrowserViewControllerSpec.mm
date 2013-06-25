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
        
        it(@"shows an experience", ^{
            controller.currentExperienceViewController.taglineLabel.text should equal(@"Run the Lyon Street stairs");
        });
        
        it(@"displays next experience when swiped", ^{
            [controller.scrollView setContentOffset:(CGPoint{ CGRectGetWidth([controller scrollView].frame), 0 })];
            [controller scrollViewDidEndDecelerating:controller.scrollView];
            controller.currentExperienceViewController.taglineLabel.text should equal(@"Check out the mural in the Mission");
        });
        
        it(@"adds an experience view controller for each experience to the scroll view", ^{
            [controller.scrollView.subviews objectAtIndex:0] should equal(controller.currentExperienceViewController.view);
            [controller.scrollView.subviews count] should equal(2);
        });
    });
});

SPEC_END
