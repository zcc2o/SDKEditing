//
//  VULCommon.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/21.
//  Copyright © 2019 zcc. All rights reserved.
//

#ifndef VULCommon_h
#define VULCommon_h

#import "NSString+EXTENSION.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 要iOS8以上支持
#define VULSCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define VULSCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define VULSCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define VULSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define VULSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define VULSCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

#define VULSCREEN_WIDTH_VARIABLE [UIScreen mainScreen].bounds.size.width
#define VULSCREEN_HEIGHT_VARIABLE [UIScreen mainScreen].bounds.size.height

// 通知中心
#define VULNotificationCenter [NSNotificationCenter defaultCenter]
// 随机颜色
#define VULRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//进制颜色 0x333333
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
// RGB颜色
#define VULRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// RGB颜色带透明度
#define VULRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kLineColor [UIColor colorWithHexString:@"#e5e5e5"] //线条颜色
//VULRGBColor(38, 150, 240)  导航栏 蓝色
#define DefaultColor [UIColor colorWithHexString:@"#2696f0"]

#define DefaultTextColor HEXCOLOR(0x73B6F5)

//灰色
#define VULGrayColor(a) VULRGBAColor(a,a,a,1.0)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SCALE_FONT (IS_IPAD ? 1.0 : ((VULSCREEN_WIDTH == 320) ? (14.5/20.0) : ((VULSCREEN_WIDTH == 375) ? (15.0/20.0) :(18.0/20.0))))

//字体
#define VULPingFangSCLight(fontSize) [UIFont fontWithName:@"PingFangSC-Light" size:fontSize * SCALE_FONT]
#define VULPingFangSCMedium(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * SCALE_FONT]
#define VULPingFangSCHeavy(fontSize) [UIFont fontWithName:@"PingFangSC-Heavy" size:fontSize * SCALE_FONT]

#define SCREENWIDTH [[UIScreen mainScreen] currentMode].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] currentMode].size.height

// 自定义导航栏的高度，在iPhone X是84，其他的上面是64
#define K_NavBar_Height ((int)((SCREENHEIGHT/SCREENWIDTH) * 100) == 216 ? 88.0 : 64.0)
// TabBar高度，在iPhone X是83，其他的上面是49
#define K_TabBar_Height ((int)((SCREENHEIGHT/SCREENWIDTH) * 100) == 216 ? 83.0 : 49.0)
//得到statueBar的高度，在iPhone X是44，其他的上面是20
#define K_StatusBar_Height ((int)((SCREENHEIGHT/SCREENWIDTH) * 100) == 216 ? 44.0 : 20.0)
//得到statueBar的高度，在iPhone X底部是34
#define K_BottomBar_Height ((int)((SCREENHEIGHT/SCREENWIDTH) * 100) == 216 ? 34 : 0)

#define kSpace 10
#define InteractionSize (IS_IPAD ? CGSizeMake(180, 180.0 * 3 / 4) : CGSizeMake(120, 90))

#define NSStringIsNotEmpty(string) [NSString nsstringIsNotEmpty:string]

#endif /* VULCommon_h */
