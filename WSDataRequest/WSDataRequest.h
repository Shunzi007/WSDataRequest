//
//  WSDataRequest.h
//  Example
//
//  Created by 王顺 on 15/6/11.
//  Copyright (c) 2015年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^WSDataResponseBlock)(id data, NSError *error);

typedef enum {
    WSDataRequestTypeGet = 0,
    WSDataRequestTypePost = 1
} WSDataRequestType;

@interface WSDataRequest : NSObject

@property (nonatomic, assign) WSDataRequestType type;
@property (nonatomic, copy)   NSString *requestURL;
@property (nonatomic, copy)   NSString *path;
@property (nonatomic, assign) double timeOut;


+ (NSError *)WSDataRequestErrorWithReason:(NSString *)reason;

+ (instancetype)request;
- (id)initWithURL:(NSString *)url;

- (NSDictionary *)baseParameters;
- (NSDictionary *)jsonParameters;

- (void)sendRequest:(WSDataResponseBlock)response;
- (id)responseParse:(id)data;

@end