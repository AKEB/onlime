//
//  TodayViewController.m
//  Onlime
//
//  Created by AKEB on 22.09.14.
//  Copyright (c) 2014 Mail.Ru Games. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Foundation/Foundation.h>
#import "MRGSASIFormDataRequest.h"
#import "MRGSJson.h"


@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

@synthesize Balance,Days;

- (void)viewDidLoad {
	NSLog(@"[WIDGET] viewDidLoad");
    [super viewDidLoad];
	
	NSURL *url = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.akeb.onlime"] URLByAppendingPathComponent:@"settings.dict"];
	
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
	
	if (dict != nil && [[dict objectForKey:@"date"] timeIntervalSince1970]+30 > [[NSDate date] timeIntervalSince1970]) {
		Days.text = [dict objectForKey:@"days"];
		Balance.text = [dict objectForKey:@"balance"];
	} else if (dict == nil) {
		
	} else {
		NSString *userLogin = [dict objectForKey:@"userLogin"];
		NSString *userPassword = [dict objectForKey:@"userPassword"];
		
		[self tryLogin:userLogin andPassword:userPassword];
		
		
	}
    // Do any additional setup after loading the view from its nib.
}


-(void) tryLogin:(NSString *) login andPassword:(NSString *) password {
	NSLog(@"[WIDGET] tryLogin");
	NSURL *url = [NSURL URLWithString:@"https://my.onlime.ru/session/login"];
	MRGSASIFormDataRequest *request = [MRGSASIFormDataRequest requestWithURL:url];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0"];
	[request setTimeOutSeconds:30];
	[request setResponseEncoding:NSUTF8StringEncoding];
	[request setPostValue:login forKey:@"login_credentials[login]"];
	[request setPostValue:password forKey:@"login_credentials[password]"];
	[request setPostValue:@"commit" forKey:@"submit"];
	[request setTimeOutSeconds:30];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailedLogin:)];
	[request setDidFinishSelector:@selector(uploadFinishedLogin:)];
	[request startAsynchronous];
}

- (void)uploadFailedLogin:(MRGSASIHTTPRequest *)theRequest {
	NSLog(@"[WIDGET] Request failed:\r\n%@",[[theRequest error] localizedDescription]);
}

- (void)uploadFinishedLogin:(MRGSASIHTTPRequest *)theRequest {
	NSLog(@"[WIDGET] uploadFinishedLogin");
	NSURL *url = [NSURL URLWithString:@"https://my.onlime.ru/json/cabinet"];
	MRGSASIFormDataRequest *request = [MRGSASIFormDataRequest requestWithURL:url];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0"];
	[request setTimeOutSeconds:30];
	[request setResponseEncoding:NSUTF8StringEncoding];
	[request setTimeOutSeconds:30];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailedCabinet:)];
	[request setDidFinishSelector:@selector(uploadFinishedCabinet:)];
	[request startAsynchronous];
	
}

- (void)uploadFailedCabinet:(MRGSASIHTTPRequest *)theRequest {
	NSLog(@"[WIDGET] Request failed:\r\n%@",[[theRequest error] localizedDescription]);
}

- (void)uploadFinishedCabinet:(MRGSASIHTTPRequest *)theRequest {
	NSLog(@"[WIDGET] uploadFinishedCabinet");
	NSDictionary *obj = (NSDictionary *)[MRGSJson objectWithString:[theRequest responseString]];
	NSString *error = [obj objectForKey:@"error"];
	if (error) {
	} else {
		NSLog(@"%@",obj);
		
		NSString *lock = @"";
		if ([[obj objectForKey:@"lock"] integerValue] >= 1000) {
			lock = @" более 100";
		} else {
			lock = [NSString stringWithFormat:@"%@",[obj objectForKey:@"lock"]];
		}
		
		NSString *_balance = [NSString stringWithFormat:@"%@ руб.",[obj objectForKey:@"balance"]];
		
		NSURL *url = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.akeb.onlime"] URLByAppendingPathComponent:@"settings.dict"];
		
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
		NSString *userLogin = [dict objectForKey:@"userLogin"];
		NSString *userPassword = [dict objectForKey:@"userPassword"];
		
		NSDictionary *dict_NEW = [NSDictionary dictionaryWithObjectsAndKeys:_balance, @"balance", lock, @"days", userLogin, @"userLogin", userPassword, @"userPassword",[NSDate date],@"date", nil];
		[dict_NEW writeToURL:url atomically:YES];
		
		Days.text = lock;
		Balance.text = _balance;
		
	}
}


- (void)didReceiveMemoryWarning {
	NSLog(@"[WIDGET] didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
	NSLog(@"[WIDGET] widgetPerformUpdateWithCompletionHandler");
	
	
	
	// Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
	
	
	
	
	
	
	
	
	
	
    completionHandler(NCUpdateResultNewData);
}

- (IBAction)openapp:(id)sender {
	NSLog(@"[WIDGET] openapp");
	NSExtensionContext *extensionContext = [self extensionContext];
	[extensionContext openURL:[NSURL URLWithString:@"onlimeBalance://widget"] completionHandler:nil];
}
@end
