//  $Id: MRGSJson.m 306 2012-10-23 11:23:08Z u.lysenkov $
//
//  MRGSJson.m
//  MRGServiceFramework
//
//  Created by Yuriy Lisenkov on 22.10.12.
//  Copyright (c) 2012 Mail.Ru Games. All rights reserved.
//

#import "MRGSJson.h"
#import "MRGSJSONLIB.h"

#pragma mark -
#pragma mark Public methods

@implementation MRGSJson

-(id)init {
	if (self = [super init]) {		
	}
	return self;
}

+(id)objectWithString:(NSString *)string {
    MRGSJsonParser *parser = [[MRGSJsonParser alloc] init];
    return [parser objectWithString:string];
}

+(id)stringWithObject:(id)object {
    MRGSJsonWriter *writer = [[MRGSJsonWriter alloc] init];
	return [writer stringWithObject:object];
}

-(id)objectWithString:(NSString *)string {
    return [MRGSJson objectWithString:string];
}

-(id)stringWithObject:(id)object {
	return [MRGSJson stringWithObject:object];
}

@end
