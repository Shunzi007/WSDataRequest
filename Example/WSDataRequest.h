//
//  WSDataRequest.h
//  Example
//
//  Created by Wang, Shun on 16/3/20.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<WSDataRequest/WSDataRequest.h>)
FOUNDATION_EXPORT double WSDataRequestVersionNumber;
FOUNDATION_EXPORT const unsigned char WSDataRequestVersionString[];
#import <WSDataRequest/NSObject+WSDataRequest.h>
#else
#import "NSObject+WSDataRequest.h"
#endif /* WSDataRequest_h */
