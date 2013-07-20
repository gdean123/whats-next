#import "ExperienceBrowserViewController.h"
#import "FakeExperienceRepository.h"
#import "Experience.h"
#import "ExperienceViewController.h"
#import "SpinnerViewController.h"
#import "ExperienceBrowserScrollView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ExperienceBrowserViewControllerSpec)

describe(@"ExperienceBrowserViewController", ^{
    __block ExperienceBrowserViewController *controller;
    __block FakeExperienceRepository *repository;
    __block NSArray *firstGroup;
    __block NSArray *secondGroup;
    __block NSArray *thirdGroup;

    void(^swipeToPage)(int, ScrollDirection) = ^(int page, ScrollDirection direction) {
        [controller.scrollView setContentOffset:(CGPoint{ CGRectGetWidth([controller scrollView].frame) * (page - 1), 0 })];
        [controller scrollViewDidSwipeInDirection:direction];
    };
    
    NSString *(^currentTagline)() = ^() {
        return ((ExperienceViewController *)controller.currentViewController).taglineLabel.text;
    };

    NSArray *(^createGroupWithTaglines)(NSArray *taglines) = ^(NSArray *taglines) {
        NSMutableArray *experiences = [[NSMutableArray alloc] init];

        for (int taglineIndex = 0; taglineIndex < [taglines count]; taglineIndex++) {
            Experience *experience = [[Experience alloc] initWithTagline:taglines[taglineIndex] image:nil latitude:37.788319 longitude:-122.40744];
            
            [experiences addObject:experience];
        }
        
        return experiences;
    };
    
    beforeEach(^{
        firstGroup = createGroupWithTaglines(@[@"Run the Lyon Street stairs",
                                             @"Check out the mural in the Mission",
                                             @"Watch the sunset on the Dumbarton bridge"]);
        secondGroup = createGroupWithTaglines(@[@"Visit the Rengstorff House",
                                              @"Ride a ship to freedom",
                                              @"Jump on a trampoline"]);
        thirdGroup = createGroupWithTaglines(@[@"Jump out of an airplane"]);
        
        repository = [[FakeExperienceRepository alloc] init];
        controller = [[ExperienceBrowserViewController alloc] initWithRepository:repository];
        [controller.view setNeedsDisplay];
    });
    
    it(@"shows a spinner", ^{
        controller.scrollView.subviews[0] should equal(controller.spinnerViewController.view);
    });

    context(@"when the request for the first group returns", ^{
        beforeEach(^{
            repository.successBlock(firstGroup);
            [controller.currentViewController.view setNeedsDisplay];
        });      
        
        it(@"shows the first experience", ^{            
             currentTagline() should equal(@"Run the Lyon Street stairs");
        });
        
        it(@"shows the second and third experiences when swiped right", ^{
            swipeToPage(2, ScrollDirectionRight);
            currentTagline() should equal(@"Check out the mural in the Mission");
            
            swipeToPage(3, ScrollDirectionRight);
            currentTagline() should equal(@"Watch the sunset on the Dumbarton bridge");
        });
        
        it(@"shows a spinner in place of the fourth experience and makes a network request", ^{
            controller.scrollView.subviews[3] should equal(controller.spinnerViewController.view);
        
            repository.group should equal(1);
            swipeToPage(4, ScrollDirectionRight);
            repository.group should equal(2);
        });
        
        context(@"when the request for the second group returns", ^{
            beforeEach(^{
                swipeToPage(4, ScrollDirectionRight);
                repository.successBlock(secondGroup);
            });
            
            it(@"shows the fourth experience", ^{
                currentTagline() should equal(@"Visit the Rengstorff House");
            });
            
            it(@"does not make a new request when swiping left", ^{
                swipeToPage(7, ScrollDirectionRight);
                repository.group should equal(3);
                swipeToPage(4, ScrollDirectionLeft);
                repository.group should equal(3);
            });
        });
    });
});

SPEC_END
