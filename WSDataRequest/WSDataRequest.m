//
//  WSDataRequest.m
//  Example
//
//  Created by 王顺 on 15/6/11.
//  Copyright (c) 2015年 wangshun. All rights reserved.
//

#import "WSDataRequest.h"
NSString *const WSErrorDomain = @"WSDataRequestError";
CGFloat   const WSRequstTimeoutInterval = 5.0;

@interface WSDataRequest ()

@property (nonatomic, strong) AFHTTPResponseSerializer *responseSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer  *requestSerializer;
@property (nonatomic, strong) NSSet *acceptableContentTypes;
@property (nonatomic, strong) id requestParameters;


@end

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
        self.timeOut = WSRequstTimeoutInterval;
        self.path = @"";
    }
    return self;
}

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        self.type = WSDataRequestTypeGet;
        self.requestURL = url;
        self.path = @"";

    }
    return self;
}

- (void)buildRequest
{
    if (!self.path) {
        self.path = @"";
    }
    if (!self.timeOut) {
        self.timeOut = WSRequstTimeoutInterval;
    }
    self.requestURL = [self.requestURL stringByAppendingString:self.path];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:[self baseParameters]];
    
    // json参数
    NSDictionary *jsonParam = [self jsonParameters];
    if (jsonParam) {
        [param addEntriesFromDictionary:jsonParam];
    }
    self.requestParameters = [NSDictionary dictionaryWithDictionary:param];

}

- (NSDictionary *)baseParameters {
    return nil;
}

- (NSDictionary *)jsonParameters {
    return nil;
}

- (id)responseParse:(id)data
{
    return nil;
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
        NSError *err = [WSDataRequest WSDataRequestErrorWithReason:@"不支持的请求类型"];
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
    
    manager.requestSerializer.timeoutInterval = self.timeOut;
    
    [manager GET:self.requestURL parameters:self.requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id data = [self responseParse:responseObject];
        if (nil != data) {
            if ([data isKindOfClass:[NSError class]]) {
                responese(nil, data);
            }else {
                responese(data, nil);
            }
        }
        else {
            NSError *err = [WSDataRequest WSDataRequestErrorWithReason:@"数据解析错误"];
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
    
    manager.requestSerializer.timeoutInterval = self.timeOut;
    [manager POST:self.requestURL parameters:self.requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id data = [self responseParse:responseObject];
        if (nil != data) {
            if ([data isKindOfClass:[NSError class]]) {
                responese(nil, data);
            }else {
                responese(data, nil);
            }
        }
        else {
            NSError *err = [WSDataRequest WSDataRequestErrorWithReason:@"数据解析错误"];
            responese(nil, err);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        responese(nil, error);
    }];
}

+ (NSError *)WSDataRequestErrorWithReason:(NSString *)reason {
    return [NSError errorWithDomain:WSErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: reason}];
}

@end
