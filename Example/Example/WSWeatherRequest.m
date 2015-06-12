//
//  WSWeatherRequest.m
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "WSWeatherRequest.h"
#import <Mantle.h>
/*
 http://route.showapi.com/9-2?showapi_appid=187&showapi_sign=simple_11be041a6d864c849b7e17d75ec663d3&areaid=101291401&showapi_timestamp=2014-11-1414:22:39
 */
@implementation WSWeatherRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestURL = @"http://route.showapi.com/9-2";
        self.type = WSDataRequestTypeGet;
    }
    return self;
}

- (id)responseParse:(id)data {
    return nil;
}


@end
