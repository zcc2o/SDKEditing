//
//  UIView+EXTENSION.h
//  VideoULimit
//
//  Created by 章程程 on 2018/9/4.
//  Copyright © 2018年 svnlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EXTENSION)

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

//填充
- (void)overlayClippingWithView:(UIView *)view cropRect:(CGRect)cropRect andColor:(UIColor *)color;

@end
