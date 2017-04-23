//
//  NSObject+WSDataRequest.m
//  Example
//
//  Created by Wang, Shun on 16/3/20.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "NSObject+WSDataRequest.h"
#import <objc/runtime.h>


NSString *const WSErrorDomain = @"WSDataRequestError";
double   const WSRequstTimeoutInterval = 5.0;

WSDataRequestType   _requestType;
double              _requestTimeOut;

static const void *typeKey = &typeKey;
static const void *timeOutKey = &timeOutKey;
static const void *requestURLKey = &requestURLKey;
static const void *pathKey = &pathKey;
static const void *responseSerializerKey = &responseSerializerKey;
static const void *requestSerializerKey = &requestSerializerKey;
static const void *acceptableContentTypesKey = &acceptableContentTypesKey;
static const void *requestParametersKey = &requestParametersKey;


@implementation NSObject (WSDataRequest)

+ (instancetype)request {
    return [[[self class] alloc] init];
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
    return data;
}

- (NSError *)responseError:(NSError *)error {
    return error;
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
        NSError *err = [NSObject errorWithErrorCode:-10001 withReason:@"does not support the request type"];
        response(nil, err);
    }
}

- (void)sendGet:(WSDataResponseBlock)responese
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (self.responseSerializer) {
        manager.responseSerializer = self.responseSerializer;
    }
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    if (self.acceptableContentTypes) {
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    }
    else {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"text/json", @"application/json", nil];
    }
    
    manager.requestSerializer.timeoutInterval = self.timeOut;
    
    [manager GET:self.requestURL parameters:self.requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [self responseParse:responseObject];
        if (nil != data) {
            if ([data isKindOfClass:[NSError class]]) {
                responese(nil, data);
            }else {
                responese(data, nil);
            }
        }
        else {
            NSError *err = [NSObject errorWithErrorCode:-10001 withReason:@"data parsing errors"];
            responese(nil, err);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responese(nil, [self responseError:error]);
    }];
    
}

- (void)sendPost:(WSDataResponseBlock)responese
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    if (self.responseSerializer) {
        manager.responseSerializer = self.responseSerializer;
    }
    
    if (self.acceptableContentTypes) {
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    }
    else {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"text/json", @"application/json", nil];
    }
    
    if (self.requestSerializer) {
        manager.requestSerializer = self.requestSerializer;
    }
    
    manager.requestSerializer.timeoutInterval = self.timeOut;
    [manager POST:self.requestURL parameters:self.requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [self responseParse:responseObject];
        if (nil != data) {
            if ([data isKindOfClass:[NSError class]]) {
                responese(nil, data);
            }else {
                responese(data, nil);
            }
        }
        else {
            NSError *err = [NSObject errorWithErrorCode:-10001 withReason:@"data parsing errors"];
            responese(nil, err);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responese(nil, [self responseError:error]);
    }];

}

+ (NSError *)errorWithErrorCode:(NSInteger)errorCode withReason:(NSString *)reason {
    return [NSError errorWithDomain:WSErrorDomain code:errorCode userInfo:@{NSLocalizedFailureReasonErrorKey: reason}];
}


#pragma mark - setter&getter

- (void)setType:(WSDataRequestType)type {
    _requestType = type;
}

- (WSDataRequestType)type {
    return _requestType;
}

- (void)setTimeOut:(double)timeOut {
    _requestTimeOut = timeOut;
}

- (double)timeOut {
    return _requestTimeOut;
}

- (void)setRequestURL:(NSString *)requestURL {
    objc_setAssociatedObject(self, requestURLKey, requestURL, OBJC_ASSOCIATION_COPY);
}

- (NSString *)requestURL {
    return objc_getAssociatedObject(self, requestURLKey);
}

- (void)setPath:(NSString *)path {
    objc_setAssociatedObject(self, pathKey, path, OBJC_ASSOCIATION_COPY);
}

- (NSString *)path {
    return objc_getAssociatedObject(self, pathKey);
}

- (void)setRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    objc_setAssociatedObject(self, requestSerializerKey, requestSerializer, OBJC_ASSOCIATION_RETAIN);
}

- (AFHTTPRequestSerializer *)requestSerializer {
    return objc_getAssociatedObject(self, requestSerializerKey);
}
- (void)setResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
    objc_setAssociatedObject(self, responseSerializerKey, responseSerializer, OBJC_ASSOCIATION_RETAIN);
}

- (AFHTTPResponseSerializer *)responseSerializer {
    return objc_getAssociatedObject(self, responseSerializerKey);
}

- (void)setAcceptableContentTypes:(NSSet *)acceptableContentTypes {
    objc_setAssociatedObject(self, acceptableContentTypesKey, acceptableContentTypes, OBJC_ASSOCIATION_RETAIN);
}

- (NSSet *)acceptableContentTypes {
    return objc_getAssociatedObject(self, acceptableContentTypesKey);
}

- (void)setRequestParameters:(id)requestParameters {
    objc_setAssociatedObject(self, requestParametersKey, requestParameters, OBJC_ASSOCIATION_RETAIN);
}

- (id)requestParameters {
    return objc_getAssociatedObject(self, requestParametersKey);
}

@end
