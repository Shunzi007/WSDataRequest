//
//  TestRequest.m
//  Example
//
//  Created by Wang,Shun on 2017/4/21.
//  Copyright © 2017年 wangshun. All rights reserved.
//

#import "TestRequest.h"

@implementation TestRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestURL = @"https://api.onevcat.com/users/onevcat";
        self.type = WSDataRequestTypeGet;
        self.timeOut = 10.0;
    }
    return self;
}

- (id)responseParse:(id)data {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return [TestRequest errorWithErrorCode:-10001 withReason:@"API error"];
    }
    return data;
}

- (NSError *)responseError:(NSError *)error {
    NSLog(@"%ld", error.resposeStatusCode);
    return error;
}

@end
