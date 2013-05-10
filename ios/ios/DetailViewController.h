//
//  DetailViewController.h
//  ios
//
//  Created by George Dean on 5/10/13.
//  Copyright (c) 2013 George Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
