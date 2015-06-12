//
//  WSCityModel.h
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface WSCityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double   longitude;
@property (nonatomic, assign) double   latitude;


@end
