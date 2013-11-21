//
//  MRGSASIHTTPRequestDelegate.h
//  Part of MRGSASIHTTPRequest -> http://allseeing-i.com/MRGSASIHTTPRequest
//
//  Created by Ben Copsey on 13/04/2010.
//  Copyright 2010 All-Seeing Interactive. All rights reserved.
//

@class MRGSASIHTTPRequest;

@protocol MRGSASIHTTPRequestDelegate <NSObject>

@optional

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
- (void)requestStarted:(MRGSASIHTTPRequest *)request;
- (void)request:(MRGSASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(MRGSASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(MRGSASIHTTPRequest *)request;
- (void)requestFailed:(MRGSASIHTTPRequest *)request;
- (void)requestRedirected:(MRGSASIHTTPRequest *)request;

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(MRGSASIHTTPRequest *)request didReceiveData:(NSData *)data;

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(MRGSASIHTTPRequest *)request;
- (void)proxyAuthenticationNeededForRequest:(MRGSASIHTTPRequest *)request;

@end
