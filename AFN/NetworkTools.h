//
//  NetworkTools.h
//  AFN
//
//  Created by 谢毅 on 16/12/15.
//  Copyright © 2016年 xieyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
//对象直接继承AFHTTPSessionManager

typedef enum : NSUInteger {
    GET,
    POST,
} XY_RequestMethod;
@interface NetworkTools : AFHTTPSessionManager

+(instancetype)sharedTools;
-(void)request:(NSString *)URlString parameters:(id)parameters finished:(void (^)(id resut, NSError *error))finished;
-(void)request:(XY_RequestMethod)method Urlstring:(NSString *)URlString parameters:(id)parameters finished:(void (^)(id resut, NSError *error))finished;
@end
