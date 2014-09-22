//
//  TodayViewController.h
//  Onlime
//
//  Created by AKEB on 22.09.14.
//  Copyright (c) 2014 Mail.Ru Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *Balance;
@property (retain, nonatomic) IBOutlet UILabel *Days;
- (IBAction)openapp:(id)sender;

@end
