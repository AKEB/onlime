//
//  ViewController.m
//  onlime
//
//  Created by AKEB on 15.11.12.
//  Copyright (c) 2012 Mail.Ru Games. All rights reserved.
//

#import "ViewController.h"
#import "MRGSASIFormDataRequest.h"
#import "MRGSJson.h"

@interface ViewController ()

@end

@implementation ViewController


-(void) loginViewShow:(NSString *) error {
	[_loginError setText:error];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *userLogin = [defaults objectForKey:@"userLogin"];
	NSString *userPassword = [defaults objectForKey:@"userPassword"];
	
	[_loginName setText:userLogin];
	[_loginPassword setText:userPassword];
	
	[_myRootView addSubview:_loginView];
	
}

-(void) loginViewHide {
	[_loginView removeFromSuperview];
}

-(void) detailViewShow {
	[_myRootView addSubview:_detailView];
}

-(void) detailViewHide {
	[_detailView removeFromSuperview];
}




- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *userLogin = [defaults objectForKey:@"userLogin"];
	NSString *userPassword = [defaults objectForKey:@"userPassword"];
	
	if ([userLogin length] < 1 || [userPassword length] < 1) {
		[self loginViewShow:nil];
		
	} else {
		[self tryLogin:userLogin andPassword:userPassword];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadFailedLogin:(MRGSASIHTTPRequest *)theRequest {
	NSLog(@"Request failed:\r\n%@",[[theRequest error] localizedDescription]);
	
	[self loginViewShow:@"Ошибка подключения к серверу!"];
	
}

- (void)uploadFinishedLogin:(MRGSASIHTTPRequest *)theRequest {
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
	NSLog(@"Request failed:\r\n%@",[[theRequest error] localizedDescription]);
	[self loginViewShow:@"Ошибка подключения к серверу!"];
}

- (void)uploadFinishedCabinet:(MRGSASIHTTPRequest *)theRequest {
	NSDictionary *obj = (NSDictionary *)[MRGSJson objectWithString:[theRequest responseString]];
	NSString *error = [obj objectForKey:@"error"];
	if (error) {
		if ([error isEqualToString:@"not logged in"]) {
			[self loginViewShow:@"Не правильный логин/пароль!"];
		} else {
			[self loginViewShow:error];
		}
	} else {
		[[UIApplication sharedApplication] cancelAllLocalNotifications];
		
		NSLog(@"%@",obj);
		
		NSString *lock = @"";
		if ([[obj objectForKey:@"lock"] integerValue] >= 1000) {
			lock = @" более 100";
		} else {
			lock = [NSString stringWithFormat:@"%@",[obj objectForKey:@"lock"]];
		}

		[_contract setText:[NSString stringWithFormat:@"%@",[obj objectForKey:@"contract"]]];
		[_account setText:[NSString stringWithFormat:@"%@",[obj objectForKey:@"account"]]];
		[_balance setText:[NSString stringWithFormat:@"%@ руб.",[obj objectForKey:@"balance"]]];
		[_lock setText:[NSString stringWithFormat:@"%@",lock]];
		[_points setText:[NSString stringWithFormat:@"%@ баллов.",[obj objectForKey:@"points"]]];

		
		
		int day = [[obj objectForKey:@"lock"] integerValue];
		
		if (day < 600) {
			if (day >= 5) {
				NSDate *date5 = [NSDate dateWithTimeIntervalSinceNow:(day*86400) -5*86400 + 5*60];
				NSLog(@"Push 5 = %@",[date5 description]);
				
				UILocalNotification *localNotif5 = [[UILocalNotification alloc] init];
				localNotif5.fireDate = date5;
				localNotif5.timeZone = [NSTimeZone defaultTimeZone];
				localNotif5.alertBody = [NSString stringWithFormat:@"Осталось 5 дней до блокировки аккаунта"];
				localNotif5.soundName = UILocalNotificationDefaultSoundName;
				localNotif5.applicationIconBadgeNumber = 5;
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotif5];
			}
			if (day >= 4) {
				NSDate *date4 = [NSDate dateWithTimeIntervalSinceNow:(day*86400) -4*86400 + 5*60];
				NSLog(@"Push 4 = %@",[date4 description]);
				
				UILocalNotification *localNotif4 = [[UILocalNotification alloc] init];
				localNotif4.fireDate = date4;
				localNotif4.timeZone = [NSTimeZone defaultTimeZone];
				localNotif4.alertBody = [NSString stringWithFormat:@""];
				localNotif4.soundName = UILocalNotificationDefaultSoundName;
				localNotif4.applicationIconBadgeNumber = 4;
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotif4];
			}
			if (day >= 3) {
				NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:(day*86400) -3*86400 + 5*60];
				NSLog(@"Push 3 = %@",[date3 description]);
				
				UILocalNotification *localNotif3 = [[UILocalNotification alloc] init];
				localNotif3.fireDate = date3;
				localNotif3.timeZone = [NSTimeZone defaultTimeZone];
				localNotif3.alertBody = [NSString stringWithFormat:@"Осталось 3 дня до блокировки аккаунта"];
				localNotif3.soundName = UILocalNotificationDefaultSoundName;
				localNotif3.applicationIconBadgeNumber = 3;
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotif3];
			}
			if (day >= 2) {
				NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:(day*86400) -2*86400 + 5*60];
				NSLog(@"Push 2 = %@",[date2 description]);
				
				UILocalNotification *localNotif2 = [[UILocalNotification alloc] init];
				localNotif2.fireDate = date2;
				localNotif2.timeZone = [NSTimeZone defaultTimeZone];
				localNotif2.alertBody = [NSString stringWithFormat:@""];
				localNotif2.soundName = UILocalNotificationDefaultSoundName;
				localNotif2.applicationIconBadgeNumber = 2;
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotif2];
			}
			
			if (day >= 1) {
				NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:(day*86400) -1*86400 + 5*60];
				NSLog(@"Push 1 = %@",[date1 description]);
				
				UILocalNotification *localNotif1 = [[UILocalNotification alloc] init];
				localNotif1.fireDate = date1;
				localNotif1.timeZone = [NSTimeZone defaultTimeZone];
				localNotif1.alertBody = [NSString stringWithFormat:@"Остался 1 день до блокировки аккаунта"];
				localNotif1.soundName = UILocalNotificationDefaultSoundName;
				localNotif1.applicationIconBadgeNumber = 1;
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotif1];
			}
		}
		[self detailViewShow];
	}
}

+ (NSString*) unescapeUnicodeString:(NSString*)string {
	// unescape quotes and backwards slash
	NSString* unescapedString = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
	unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
	
	// tokenize based on unicode escape char
	NSMutableString* tokenizedString = [NSMutableString string];
	NSScanner* scanner = [NSScanner scannerWithString:unescapedString];
	while ([scanner isAtEnd] == NO)
	{
		// read up to the first unicode marker
		// if a string has been scanned, it's a token
		// and should be appended to the tokenized string
		NSString* token = @"";
		[scanner scanUpToString:@"\\u" intoString:&token];
		if (token != nil && token.length > 0)
		{
			[tokenizedString appendString:token];
			continue;
		}
		
		// skip two characters to get past the marker
		// check if the range of unicode characters is
		// beyond the end of the string (could be malformed)
		// and if it is, move the scanner to the end
		// and skip this token
		NSUInteger location = [scanner scanLocation];
		NSInteger extra = scanner.string.length - location - 4 - 2;
		if (extra < 0)
		{
			NSRange range = {location, -extra};
			[tokenizedString appendString:[scanner.string substringWithRange:range]];
			[scanner setScanLocation:location - extra];
			continue;
		}
		
		// move the location pas the unicode marker
		// then read in the next 4 characters
		location += 2;
		NSRange range = {location, 4};
		token = [scanner.string substringWithRange:range];
		unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
		[tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
		
		// move the scanner past the 4 characters
		// then keep scanning
		location += 4;
		[scanner setScanLocation:location];
	}
	
	// done
	return tokenizedString;
}

+ (NSString*) escapeUnicodeString:(NSString*)string {
	// lastly escaped quotes and back slash
	// note that the backslash has to be escaped before the quote
	// otherwise it will end up with an extra backslash
	NSString* escapedString = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
	escapedString = [escapedString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	
	// convert to encoded unicode
	// do this by getting the data for the string
	// in UTF16 little endian (for network byte order)
	NSData* data = [escapedString dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:YES];
	size_t bytesRead = 0;
	const char* bytes = data.bytes;
	NSMutableString* encodedString = [NSMutableString string];
	
	// loop through the byte array
	// read two bytes at a time, if the bytes
	// are above a certain value they are unicode
	// otherwise the bytes are ASCII characters
	// the %C format will write the character value of bytes
	while (bytesRead < data.length)
	{
		uint16_t code = *((uint16_t*) &bytes[bytesRead]);
		if (code > 0x007E)
		{
			[encodedString appendFormat:@"\\u%04X", code];
		}
		else
		{
			[encodedString appendFormat:@"%C", code];
		}
		bytesRead += sizeof(uint16_t);
	}
	
	// done
	return encodedString;
}




-(void) tryLogin:(NSString *) login andPassword:(NSString *) password {
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


- (IBAction)Login:(id)sender {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[_loginName text] forKey:@"userLogin"];
	[defaults setObject:[_loginPassword text] forKey:@"userPassword"];
	
	[self loginViewHide];
	
	[self tryLogin:[_loginName text] andPassword:[_loginPassword text]];
}

- (IBAction)Logout:(id)sender {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//[defaults setObject:@"" forKey:@"userLogin"];
	[defaults setObject:@"" forKey:@"userPassword"];
	
	NSURL *url = [NSURL URLWithString:@"https://my.onlime.ru/session/logout"];
	MRGSASIFormDataRequest *request = [MRGSASIFormDataRequest requestWithURL:url];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0"];
	[request setTimeOutSeconds:30];
	[request setResponseEncoding:NSUTF8StringEncoding];
	[request setTimeOutSeconds:30];
	[request startAsynchronous];

	[self detailViewHide];
	[self loginViewShow:nil];
	
}

- (IBAction)Refresh:(id)sender {
	[self detailViewHide];
	[self uploadFinishedLogin:nil];
}

- (void)dealloc {
	[_myRootView release];
	[_loginView release];
	[_loginName release];
	[_loginPassword release];
	[_loginError release];
	[_detailView release];
	[_contract release];
	[_account release];
	[_balance release];
	[_lock release];
	[_points release];
	[super dealloc];
}
- (void)viewDidUnload {
	[self setMyRootView:nil];
	[self setLoginView:nil];
	[self setLoginName:nil];
	[self setLoginPassword:nil];
	[self setLoginError:nil];
	[self setDetailView:nil];
	[self setContract:nil];
	[self setAccount:nil];
	[self setBalance:nil];
	[self setLock:nil];
	[self setPoints:nil];
	[super viewDidUnload];
}

@end
