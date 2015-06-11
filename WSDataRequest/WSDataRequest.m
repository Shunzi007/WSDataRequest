//
//  WSDataRequest.m
//  Example
//
//  Created by 王顺 on 15/6/11.
//  Copyright (c) 2015年 wangshun. All rights reserved.
//

#import "WSDataRequest.h"
NSString *const WSErrorDomain = @"WSDataRequest";
CGFloat   const OPRequstTimeoutInterval = 5.0;

@implementation WSDataRequest

+ (instancetype)request
{
    return [[[self class] alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.type = WSDataRequestTypeGet;
    }
    return self;
}

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        self.type = WSDataRequestTypeGet;
        self.requestURL = url;
    }
    return self;
}

- (void)buildRequest
{
    
}

- (id)responseParse:(id)data
{
    return data;
}

- (void)sendRequest:(WSDataResponseBlock)response
{
    [self buildRequest];
    
    if (WSDataRequestTypeGet == self.type) {
        [self sendGet:response];
    }
    else if (WSDataRequestTypePost == self.type) {
        [self sendPost:response];
    }
    else {
        NSError *err = [NSError errorWithDomain:WSErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: @"unsupport request type."}];
        response(nil, err);
    }
}

- (void)sendGet:(WSDataResponseBlock)responese
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (self.responseSerializer) {
        manager.responseSerializer = self.responseSerializer;
    }
    
    if (_acceptableContentTypes) {
        manager.responseSerializer.acceptableContentTypes = _acceptableContentTypes;
    }
    else {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    }
    
    manager.requestSerializer.timeoutInterval = OPRequstTimeoutInterval;
    
    [manager GET:self.requestURL parameters:self.requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id data = [self responseParse:responseObject];
        if (nil != data) {
            responese(data, nil);
        }
        else {
            NSError *err = [NSError errorWithDomain:WSErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: @"unsupport respone data."}];
            responese(nil, err);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        responese(nil, error);
    }];
}

- (void)sendPost:(WSDataResponseBlock)responese
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (self.responseSerializer) {
        manager.responseSerializer = self.responseSerializer;
    }
    
    if (_acceptableContentTypes) {
        manager.responseSerializer.acceptableContentTypes = _acceptableContentTypes;
    }
    else {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    }
    
    if (_requestSerializer) {
        manager.requestSerializer = _requestSerializer;
    }
    
    manager.requestSerializer.timeoutInterval = OPRequstTimeoutInterval;
    [manager POST:self.requestURL parameters:self.requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id parsedData = [self responseParse:responseObject];
        if (nil != parsedData) {
            responese(parsedData, nil);
        }
        else {
            NSError *err = [NSError errorWithDomain:WSErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: @"unsupport respone data."}];
            responese(nil, err);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        responese(nil, error);
    }];
}

@end
