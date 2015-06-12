//
//  WSWeatherModel.m
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "WSWeatherModel.h"

@implementation WSWeatherModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"day_weather"             : @"day_weather",
             @"night_weather"           : @"night_weather",
             @"day_air_temperature"     : @"day_air_temperature",
             @"night_air_temperature"   : @"night_air_temperature"
             };
}

@end
