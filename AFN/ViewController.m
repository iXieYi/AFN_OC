//
//  ViewController.m
//  AFN
//
//  Created by 谢毅 on 16/12/15.
//  Copyright © 2016年 xieyi. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTools.h"
@interface ViewController ()

@end

@implementation ViewController
/*
 AFN最常见的网路请求错误
 1、不支持内容：status code = 200 需要进行反序列化
 2、          status code = 405，对应的URL 不支持http请求方法，例如向post的URL 中请求Get方法->会提示方法不被允许
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NetworkTools sharedTools] request:@"data/sk/101010100.html" parameters:nil finished:^(id resut, NSError *error) {
//        
//        if (error!=nil) {
//            NSLog(@"出错了");
//        }else{
//        
//            NSLog(@"%@",resut);
//        }
//    }];
    
    [[NetworkTools sharedTools] request:GET Urlstring:@"get" parameters:@{@"name":@"xieyi",@"age":@24} finished:^(id resut, NSError *error) {
             if (error!=nil) {
                    NSLog(@"出错了");
                }else{
                    NSLog(@"%@",resut);
                }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
