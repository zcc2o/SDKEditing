//
//  UIView+EXTENSION.m
//  VideoULimit
//
//  Created by 章程程 on 2018/9/4.
//  Copyright © 2018年 svnlan. All rights reserved.
//

#import "UIView+EXTENSION.h"

@implementation UIView (EXTENSION)

- (void)setSize:(CGSize)size
{
    self.frame = (CGRect){{self.frame.origin.x, self.frame.origin.y}, size};
}

- (void)setOrigin:(CGPoint)origin
{
    self.frame = (CGRect){origin, {self.frame.size.width, self.frame.size.height}};
}

- (void)setX:(CGFloat)x
{
    self.frame = (CGRect){{x, self.frame.origin.y}, self.frame.size};
}

- (void)setY:(CGFloat)y
{
    self.frame = (CGRect){{self.frame.origin.x, y}, self.frame.size};
}

- (void)setWidth:(CGFloat)width
{
    self.frame = (CGRect){self.frame.origin, {width, self.frame.size.height}};
}

- (void)setHeight:(CGFloat)height
{
    self.frame = (CGRect){self.frame.origin, {self.frame.size.width, height}};
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return  self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)overlayClippingWithView:(UIView *)view cropRect:(CGRect)cropRect andColor:(UIColor *)color{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:cropRect.size.width / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleNonZero;
    layer.fillColor = color.CGColor;
    [view.layer insertSublayer:layer below:view.layer];
}


@end
