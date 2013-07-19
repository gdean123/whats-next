#import "ExperienceBrowserViewController.h"
#import "FakeExperienceRepository.h"
#import "Experience.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserViewControllerSpec)

describe(@"ExperienceBrowserViewController", ^{
    __block ExperienceBrowserViewController *controller;
    __block FakeExperienceRepository *repository;
    __block Experience *firstExperience;
    __block Experience *secondExperience;
    __block Experience *thirdExperience;
    __block Experience *fourthExperience;
    
    void(^swipeToPage)(int) = ^(int page) {
        [controller.scrollView setContentOffset:(CGPoint{ CGRectGetWidth([controller scrollView].frame) * (page - 1), 0 })];
        [controller scrollViewDidEndDecelerating:controller.scrollView];
    };
    
    NSString *(^currentTagline)() = ^() {
        return ((ExperienceViewController *)controller.currentViewController).taglineLabel.text;
    };
    
    beforeEach(^{
        firstExperience = [[Experience alloc] initWithTagline:@"Run the Lyon Street stairs" image:nil latitude:37.788319 longitude:-122.40744];
        secondExperience = [[Experience alloc] initWithTagline:@"Check out the mural in the Mission" image:nil latitude:37.788319 longitude:-122.40744];
        thirdExperience = [[Experience alloc] initWithTagline:@"Watch the sunset on the Dumbarton bridge" image:nil latitude:37.788319 longitude:-122.40744];
        fourthExperience = [[Experience alloc] initWithTagline:@"Visit the Rengstorff House" image:nil latitude:37.788319 longitude:-122.40744];
        repository = [[FakeExperienceRepository alloc] init];
        controller = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        [controller.view setNeedsDisplay];
    });
    
    it(@"shows a spinner", ^{
        controller.scrollView.subviews[0] should equal(controller.spinnerViewController.view);
    });

    context(@"when the request for the first page returns", ^{
        beforeEach(^{
            repository.successBlock(@[firstExperience, secondExperience, thirdExperience]);
            [controller.currentViewController.view setNeedsDisplay];
        });      
        
        it(@"shows the first experience", ^{            
             currentTagline() should equal(@"Run the Lyon Street stairs");
        });
        
        it(@"shows the second and third experiences when swiped right", ^{
            swipeToPage(2);            
            currentTagline() should equal(@"Check out the mural in the Mission");
            
            swipeToPage(3);
            currentTagline() should equal(@"Watch the sunset on the Dumbarton bridge");
        });
        
        it(@"shows a spinner in place of the fourth experience", ^{
            controller.scrollView.subviews[3] should equal(controller.spinnerViewController.view);
        });
        
        context(@"when the request for the second page returns", ^{
            fit(@"shows the fourth experience", ^{
                repository.page should equal(1);
                swipeToPage(4);
                repository.page should equal(2);
                repository.successBlock(@[fourthExperience]);
                currentTagline() should equal(@"Visit the Rengstorff House");
            });
        });
    });
    
});

SPEC_END
