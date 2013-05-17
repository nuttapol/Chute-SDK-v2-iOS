//
//  GCClient.h
//  GetChute
//
//  Created by Aleksandar Trpeski on 12/7/12.
//  Copyright (c) 2012 Aleksandar Trpeski. All rights reserved.
//

#import "AFHTTPClient.h"


extern NSString * const kGCClientGET;
extern NSString * const kGCClientPOST;
extern NSString * const kGCClientPUT;
extern NSString * const kGCClientDELETE;

@class GCResponse, GCUploads;

@interface GCClient : AFHTTPClient

@property (assign, nonatomic) BOOL isLoggedIn;

+ (GCClient *)sharedClient;

- (void)setAuthorizationHeaderWithToken:(NSString *)token;
- (void)request:(NSMutableURLRequest *)request factoryClass:(Class)factoryClass success:(void (^)(GCResponse *))success failure:(void (^)(NSError *))failure;

@end
