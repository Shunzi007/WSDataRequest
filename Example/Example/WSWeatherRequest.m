//
//  WSWeatherRequest.m
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "WSWeatherRequest.h"
#import "WSReportModel.h"
/*
 http://route.showapi.com/9-2?showapi_appid=187&showapi_sign=simple_11be041a6d864c849b7e17d75ec663d3&areaid=101291401&showapi_timestamp=2014-11-1414:22:39
 */
@implementation WSWeatherRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestURL = @"http://route.showapi.com";
        self.path =@"/9-2";
        self.type = WSDataRequestTypePost;
        self.timeOut = 3;
    }
    return self;
}

- (NSDictionary *)baseParameters {
    return @{
             @"showapi_appid"     : @"187",
             @"showapi_sign"      : @"simple_11be041a6d864c849b7e17d75ec663d3"
             };
}

- (NSDictionary *)jsonParameters {
    return @{
             @"areaid"            : @"101291401",
             @"showapi_timestamp" : @"2015-12-12 00:00:00",
             };
}


- (id)responseParse:(id)data {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return [WSWeatherRequest errorWithErrorCode:-10001 withReason:@"接口错误"];
    }
    if ([[data objectForKey:@"showapi_res_error"] length]) {
        return [WSWeatherRequest errorWithErrorCode:-10001 withReason:[data objectForKey:@"showapi_res_error"]];
    }
    NSError *err = nil;
    NSDictionary *dataDict = [data objectForKey:@"showapi_res_body"];
    WSReportModel *report = [MTLJSONAdapter modelOfClass:[WSReportModel class] fromJSONDictionary:dataDict error:&err];
    if (err) {
        return err;
    }
    return report;
}

- (NSError *)responseError:(NSError *)error {
    if (error.code == -1001) {
        error = [WSWeatherRequest errorWithErrorCode:-1001 withReason:@"time out!"];
    }
    return error;
}

@end
