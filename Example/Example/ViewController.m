//
//  ViewController.m
//  Example
//
//  Created by 王顺 on 15/6/11.
//  Copyright (c) 2015年 wangshun. All rights reserved.
//

#import "ViewController.h"
#import "WSWeatherRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
};

- (IBAction)action:(id)sender {
    
    WSWeatherRequest *request = [WSWeatherRequest request];
    [request sendRequest:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }else {
            NSLog(@"%@", data);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
