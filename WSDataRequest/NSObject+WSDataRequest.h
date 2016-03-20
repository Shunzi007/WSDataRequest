//
//  NSObject+WSDataRequest.h
//  Example
//
//  Created by Wang, Shun on 16/3/20.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^WSDataResponseBlock)(id data, NSError *error);

typedef enum {
    WSDataRequestTypeGet = 0,
    WSDataRequestTypePost = 1
} WSDataRequestType;

@interface NSObject (WSDataRequest)

@property (nonatomic, assign) WSDataRequestType type;
@property (nonatomic, assign) double timeOut;
@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong, readonly) id requestParameters;

+ (instancetype)request;
+ (NSError *)errorWithErrorCode:(NSInteger)errorCode withReason:(NSString *)reason;

- (NSDictionary *)baseParameters;
- (NSDictionary *)jsonParameters;

- (void)sendRequest:(WSDataResponseBlock)response;
- (id)responseParse:(id)data;

@end
