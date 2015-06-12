//
//  WSCityModel.m
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "WSCityModel.h"

@implementation WSCityModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cityName"        : @"c3",
             @"cityCode"        : @"c1",
             @"provinceName"    : @"c7",
             @"longitude"       : @"longitude",
             @"latitude"        : @"latitude",
             };
}

@end
