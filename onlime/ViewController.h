//
//  ViewController.h
//  onlime
//
//  Created by AKEB on 15.11.12.
//  Copyright (c) 2012 Mail.Ru Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
	
}

@property (retain, nonatomic) IBOutlet UIView *myRootView;
@property (retain, nonatomic) IBOutlet UIView *loginView;
@property (retain, nonatomic) IBOutlet UIView *detailView;

@property (retain, nonatomic) IBOutlet UITextField *loginName;
@property (retain, nonatomic) IBOutlet UITextField *loginPassword;
@property (retain, nonatomic) IBOutlet UILabel *loginError;




@property (retain, nonatomic) IBOutlet UILabel *contract;
@property (retain, nonatomic) IBOutlet UILabel *account;
@property (retain, nonatomic) IBOutlet UILabel *balance;
@property (retain, nonatomic) IBOutlet UILabel *lock;
@property (retain, nonatomic) IBOutlet UILabel *points;



- (IBAction)Login:(id)sender;
- (IBAction)Logout:(id)sender;
- (IBAction)Refresh:(id)sender;

@end
