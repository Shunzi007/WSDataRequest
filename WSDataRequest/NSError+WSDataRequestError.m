//
//  NSError+WSDataRequestError.m
//  Example
//
//  Created by Wang, Shun on 16/5/25.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "NSError+WSDataRequestError.h"

NSString * const responseKey = @"com.alamofire.serialization.response.error.response";

@implementation NSError (WSDataRequestError)

- (NSInteger)resposeStatusCode {
    NSDictionary *userInfo = self.userInfo;
    if ([userInfo[responseKey] isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *respose = userInfo[responseKey];
        return respose.statusCode;
    }
    return 0;
}

@end
