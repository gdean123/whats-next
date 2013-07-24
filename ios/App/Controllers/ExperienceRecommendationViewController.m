//
//  ExperienceRecommendationViewController.m
//  ios
//
//  Created by Jason Leng on 7/23/13.
//  Copyright (c) 2013 George Dean. All rights reserved.
//

#import "ExperienceRecommendationViewController.h"

@interface ExperienceRecommendationViewController ()

@end

@implementation ExperienceRecommendationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recommend" image:nil tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
