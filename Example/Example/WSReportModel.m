//
//  WSReportModel.m
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "WSReportModel.h"

@implementation WSReportModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"reportTime"          : @"time",
             @"city"                : @"cityInfo",
             @"todayWeather"        : @"f1",
             @"tomorrowWeather"     : @"f2",
             @"afterTomoWeather"    : @"f3"
             };
}

+ (NSValueTransformer *)cityJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSCityModel class]];
}

+ (NSValueTransformer *)todayWeatherJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSWeatherModel class]];
}

+ (NSValueTransformer *)tomorrowWeatherJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSWeatherModel class]];
}

+ (NSValueTransformer *)afterTomoWeatherJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSWeatherModel class]];
}




@end
