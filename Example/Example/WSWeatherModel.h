//
//  WSWeatherModel.h
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface WSWeatherModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *day_weather;
@property (nonatomic, strong) NSString *night_weather;
@property (nonatomic, strong) NSString *day_air_temperature;
@property (nonatomic, strong) NSString *night_air_temperature;


@end
