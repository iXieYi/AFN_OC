//
//  NetworkTools.m
//  AFN
//
//  Created by 谢毅 on 16/12/15.
//  Copyright © 2016年 xieyi. All rights reserved.
//

#import "NetworkTools.h"
//网路工具协议
@protocol NetworkToolsProxy <NSObject>
/// 网络请求方法
///
/// @param method           Http请求
/// @param URLString        URL
/// @param parameters       参数字典
/// @param uploadProgress   上传进度
/// @param downloadProgress 下载进度
/// @param success          成功回调
/// @param failure          失败回调
///
/// @return      NSURLSessionDataTask
@optional        //表示可以不实现
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end
//遵守协议->有智能提示了
//目的是：能够骗过xcode给智能提示，给编译通过
@interface NetworkTools()<NetworkToolsProxy>

@end

@implementation NetworkTools

+(instancetype)sharedTools{

    static NetworkTools *tools;
    static dispatch_once_t onceToken;
    //注意结尾需要包含‘/’
    //://www.weather.com.cn
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://httpbin.org/"];
        tools = [[self alloc] initWithBaseURL:url];
        
        //设置反序列化格式
      tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    });

    return tools;
}
//隔离第三方框架
-(void) request:(NSString *)URlString parameters:(id)parameters finished:(void (^)(id resut, NSError *error))finished{
    [self GET:URlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        finished(nil,error);
    }];
}
//封装一个GET 和 POST公用的方法
-(void)request:(XY_RequestMethod)method Urlstring:(NSString *)URlString parameters:(id)parameters finished:(void (^)(id resut, NSError *error))finished{
    NSString *methodName = (method == GET)?@"GET":@"POST";
    //本类没有实现自己的方法，但是父类实现了该方法
    //在调用方法的时候，如果本类没有提供，直接调用父类的方法，AFN内部已经实现（利用继承实现）
    [[self dataTaskWithHTTPMethod:methodName URLString:URlString parameters:parameters uploadProgress:^(NSProgress *uploadProgress) {
        
        
    } downloadProgress:^(NSProgress *downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        finished(responseObject,nil);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        finished(nil,error);
        
    }] resume];
//    if (method ==GET) {
//        [self GET:URlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            NSLog(@"%@",responseObject);
//            finished(responseObject,nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            NSLog(@"%@",error);
//            finished(nil,error);
//        }];
//
//    }else{
//        [self POST:URlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            NSLog(@"%@",responseObject);
//            finished(responseObject,nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            NSLog(@"%@",error);
//            finished(nil,error);
//        }];
//
//    }
  
}

@end
