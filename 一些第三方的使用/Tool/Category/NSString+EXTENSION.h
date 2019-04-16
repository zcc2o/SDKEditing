//
//  NSString+EXTENSION.h
//  VideoULimit
//
//  Created by 章程程 on 2018/11/6.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (EXTENSION)

/**
 根据字体大小 返回文本宽高

 @param font 字体
 @param maxSize 最大size
 */
- (CGSize)sizewithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 json字典转换为json字符串

 @param dic json 字典
 */
+ (NSString *)getJsonStringWithDic:(NSDictionary *)dic;

+ (NSString *)dateStrWithTimeInterval:(NSInteger)createTimeInterval;

/** 根据图片data 判断是否是gif图 */
+ (BOOL)isGifWithImageData: (NSData *)data;

/**
 根据image的data 判断图片类型
 
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;

+(BOOL)nsstringIsNotEmpty:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
