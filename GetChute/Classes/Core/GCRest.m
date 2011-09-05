//
//  ChuteNetwork.m
//  KitchenSink
//
//  Created by Achal Aggarwal on 26/08/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "GCRest.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "GCAccount.h"

@implementation GCRest

- (NSMutableDictionary *)headers{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            kDEVICE_NAME, @"x-device-name",
            kUDID, @"x-device-identifier",
            kDEVICE_OS, @"x-device-os",
            kDEVICE_VERSION, @"x-device-version",
            [NSString stringWithFormat:@"OAuth %@", [[GCAccount sharedManager] accessToken]], @"Authorization",
            nil];
}

- (GCResponseObject *)getRequestWithPath:(NSString *)path {
    ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];    
    [_request setRequestHeaders:[self headers]];
    [_request setTimeOutSeconds:300.0];
    [_request startSynchronous];
    GCResponseObject *_result = [[[GCResponseObject alloc] initWithRequest:_request] autorelease];
    return _result;
}

- (GCResponseObject *)postRequestWithPath:(NSString *)path
                        andParams:(NSMutableDictionary *)params
                        andMethod:(NSString *)method {
    
    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
    [_request setRequestHeaders:[self headers]];
    
    if ([params objectForKey:@"raw"]) {
        [_request setPostBody:[params objectForKey:@"raw"]];
    }
    else {
        [_request setPostBody:nil];
        for (id key in [params allKeys]) {
            [_request setPostValue:[params objectForKey:key] forKey:key];
        }
    }
    [_request setRequestMethod:method];
    [_request startSynchronous];
    
    GCResponseObject *_result = [[[GCResponseObject alloc] initWithRequest:_request] autorelease];
    return _result;
}

- (GCResponseObject *)postRequestWithPath:(NSString *)path
                        andParams:(NSMutableDictionary *)params {
    return [self postRequestWithPath:path andParams:params andMethod:@"POST"];
}

- (GCResponseObject *)putRequestWithPath:(NSString *)path
               andParams:(NSMutableDictionary *)params {
    return [self postRequestWithPath:path andParams:params andMethod:@"PUT"];
}

- (GCResponseObject *)deleteRequestWithPath:(NSString *)path
                  andParams:(NSMutableDictionary *)params {
    return [self postRequestWithPath:path andParams:params andMethod:@"DELETE"];
}

#pragma mark - Background Method Calls

- (void)getRequestInBackgroundWithPath:(NSString *)path
                          withResponse:(GCResponseBlock)aResponseBlock {
    DO_IN_BACKGROUND([self getRequestWithPath:path], aResponseBlock);
}

- (void)postRequestInBackgroundWithPath:(NSString *)path
                              andParams:(NSMutableDictionary *)params
                           withResponse:(GCResponseBlock)aResponseBlock {
    DO_IN_BACKGROUND([self postRequestWithPath:path andParams:params], aResponseBlock);
}

- (void)putRequestInBackgroundWithPath:(NSString *)path
                             andParams:(NSMutableDictionary *)params
                          withResponse:(GCResponseBlock)aResponseBlock {
    DO_IN_BACKGROUND([self putRequestWithPath:path andParams:params], aResponseBlock);
}

- (void)deleteRequestInBackgroundWithPath:(NSString *)path
                                andParams:(NSMutableDictionary *)params
                             withResponse:(GCResponseBlock)aResponseBlock {
    DO_IN_BACKGROUND([self deleteRequestWithPath:path andParams:params], aResponseBlock);
}

@end