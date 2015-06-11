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
@property (nonatomic, strong) id requestParameters;
@property (nonatomic, strong) AFHTTPResponseSerializer *responseSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer  *requestSerializer;
@property (nonatomic, strong) NSSet *acceptableContentTypes;

- (id)initWithURL:(NSString *)url;
- (void)buildRequest;
- (void)sendRequest:(WSDataResponseBlock)response;
- (id)responseParse:(id)data;
+ (instancetype)request;

@end