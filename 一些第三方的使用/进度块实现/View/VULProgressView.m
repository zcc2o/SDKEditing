//
//  VULProgressView.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/19.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULProgressView.h"

@interface VULProgressView (){
    UIBezierPath *path;
    BOOL _isSelected;
}
@property (nonatomic, strong) UILabel *contentLabel;

@end

static CGFloat margin = 15;
static CGFloat lineWidth = 1;

@implementation VULProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)setProgressModel:(VULProgressModel *)progressModel {
    _progressModel = progressModel;
    self.contentLabel.text = progressModel.stateName;
    [self drawProgressViewWithStatus:progressModel.state];
}

- (void)drawProgressViewWithStatus:(BOOL)isSelected {
    _isSelected = isSelected;
    [self drawRect:self.bounds];
    self.contentLabel.frame = CGRectMake(margin + lineWidth, 0, self.frame.size.width - lineWidth - margin * 2, self.frame.size.height);
    if (isSelected) {
        self.contentLabel.textColor = [UIColor whiteColor];
    } else {
        self.contentLabel.textColor = [UIColor blueColor];
    }
    self.contentLabel.font = [UIFont systemFontOfSize:self.frame.size.height / 3];
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor blueColor];
    [color set];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinRound;
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    [path moveToPoint:CGPointMake(lineWidth, lineWidth)];
    [path addLineToPoint:CGPointMake(viewWidth - margin - lineWidth, lineWidth)];
    [path addLineToPoint:CGPointMake(viewWidth - lineWidth, (viewHeight - lineWidth) / 2)];
    [path addLineToPoint:CGPointMake(viewWidth - margin - lineWidth, viewHeight - lineWidth)];
    [path addLineToPoint:CGPointMake(lineWidth, viewHeight - lineWidth)];
    [path addLineToPoint:CGPointMake(margin + lineWidth, (viewHeight - lineWidth) / 2)];
//    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    if (_isSelected) {
        [path fill]; //填充
    } else {
        [path stroke]; //描边
    }
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
