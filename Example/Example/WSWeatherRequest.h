//
//  WSWeatherRequest.h
//  Example
//
//  Created by 王顺 on 15/6/12.
//  Copyright © 2015年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WSDataRequest.h"

@interface WSWeatherRequest : NSObject

@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *areaID;
@property (nonatomic, strong) NSString *time;


@end
