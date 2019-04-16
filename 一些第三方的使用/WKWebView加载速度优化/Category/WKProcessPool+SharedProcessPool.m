//
//  WKProcessPool+SharedProcessPool.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "WKProcessPool+SharedProcessPool.h"

@implementation WKProcessPool (SharedProcessPool)

+ (WKProcessPool *)shareProcessPool {
    static WKProcessPool *sharedProcessPool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProcessPool = [[WKProcessPool alloc] init];
    });
    return sharedProcessPool;
}

@end
