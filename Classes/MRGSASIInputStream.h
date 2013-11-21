//
//  MRGSASIInputStream.h
//  Part of MRGSASIHTTPRequest -> http://allseeing-i.com/MRGSASIHTTPRequest
//
//  Created by Ben Copsey on 10/08/2009.
//  Copyright 2009 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRGSASIHTTPRequest;

// This is a wrapper for NSInputStream that pretends to be an NSInputStream itself
// Subclassing NSInputStream seems to be tricky, and may involve overriding undocumented methods, so we'll cheat instead.
// It is used by MRGSASIHTTPRequest whenever we have a request body, and handles measuring and throttling the bandwidth used for uploading

@interface MRGSASIInputStream : NSObject {
	NSInputStream *stream;
	MRGSASIHTTPRequest *request;
}
+ (id)inputStreamWithFileAtPath:(NSString *)path request:(MRGSASIHTTPRequest *)request;
+ (id)inputStreamWithData:(NSData *)data request:(MRGSASIHTTPRequest *)request;

@property (retain, nonatomic) NSInputStream *stream;
@property (assign, nonatomic) MRGSASIHTTPRequest *request;
@end
