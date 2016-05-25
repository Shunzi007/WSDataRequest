//
//  NSError+WSDataRequestError.h
//  Example
//
//  Created by Wang, Shun on 16/5/25.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (WSDataRequestError)

@property (assign, nonatomic, readonly) NSInteger resposeStatusCode;

@end
