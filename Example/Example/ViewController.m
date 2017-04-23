//
//  ViewController.m
//  Example
//
//  Created by 王顺 on 15/6/11.
//  Copyright (c) 2015年 wangshun. All rights reserved.
//

#import "ViewController.h"
#import "TestRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
};

- (IBAction)action:(id)sender {
    
    TestRequest *request = [TestRequest request];
    [request sendRequest:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedFailureReason);
        }else {
            NSLog(@"%@", data);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
