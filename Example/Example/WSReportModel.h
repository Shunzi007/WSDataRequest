//
//  WSReportModel.h
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "MTLModel.h"
#import "WSCityModel.h"
#import "WSWeatherModel.h"

@interface WSReportModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *reportTime;
@property (nonatomic, strong) WSCityModel *city;
@property (nonatomic, strong) WSWeatherModel *todayWeather;
@property (nonatomic, strong) WSWeatherModel *tomorrowWeather;
@property (nonatomic, strong) WSWeatherModel *afterTomoWeather;

@end
