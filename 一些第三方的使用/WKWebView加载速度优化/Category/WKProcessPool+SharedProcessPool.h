//
//  WKProcessPool+SharedProcessPool.h
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProcessPool (SharedProcessPool)

+ (WKProcessPool *)shareProcessPool;

@end

NS_ASSUME_NONNULL_END
