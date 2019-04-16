//
//  NSString+EXTENSION.m
//  VideoULimit
//
//  Created by 章程程 on 2018/11/6.
//  Copyright © 2018 svnlan. All rights reserved.
//

#import "NSString+EXTENSION.h"

@implementation NSString (EXTENSION)

- (CGSize)sizewithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}


/**
 json字典转换为json字符串

 @param dic json字典
 */
+ (NSString *)getJsonStringWithDic:(NSDictionary *)dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    //去回车和空格
    NSRange range = {0, jsonStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0, mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;
}

+ (NSString *)dateStrWithTimeInterval:(NSInteger)createTimeInterval {
    createTimeInterval = createTimeInterval / 1000;
    NSDate *date = [NSDate date];
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:createTimeInterval];
    
    NSTimeInterval timeIntervalNow = [date timeIntervalSince1970];
    
    NSInteger dNum = timeIntervalNow - createTimeInterval; //现在秒数 - 过去秒数
    
    if (dNum < 60){
        NSString *rTime;
        if (dNum <= 3) {
            rTime = @"刚刚";
        } else {
            rTime = [NSString stringWithFormat:@"%ld秒前", (long)dNum];
        }
        return rTime;
    } else if (dNum >= 60 && dNum < 3600){
        NSInteger timeNum = dNum / 60;
        return [NSString stringWithFormat:@"%ld分钟前", (long)timeNum];
    } else if (dNum >= 3600 && dNum <= 86400) {
        NSInteger timeNum = dNum / 3600;
        return [NSString stringWithFormat:@"%ld小时前", (long)timeNum];
    } else if (dNum >= 86400 && dNum < 86400 * 7)      {
        NSInteger timeNum = dNum / 86400;
        return [NSString stringWithFormat:@"%ld天前", (long)timeNum];
    } else {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.timeZone = [NSTimeZone systemTimeZone];
        df.dateFormat = @"yyyy年M月d日";
        
        NSString *createYearStr = [df stringFromDate:createDate];
        NSInteger createYearNum = [[createYearStr substringToIndex:4] integerValue];
        NSLog(@"createYearNum: %ld", (long)createYearNum);
        
        NSString *dateNowStr = [df stringFromDate:date];
        NSInteger dateNowNum = [[dateNowStr substringToIndex:4] integerValue];
        
        if (dateNowNum != createYearNum) {
            return createYearStr;
        } else {
            return [createYearStr substringFromIndex:5];
        }
    }
}

+ (BOOL)isGifWithImageData: (NSData *)data {
    if ([[self contentTypeWithImageData:data] isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)contentTypeWithImageData: (NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            
            return nil;
    }
    return nil;
}


+(BOOL)nsstringIsNotEmpty:(NSString *)string {
    if (string && ![string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
