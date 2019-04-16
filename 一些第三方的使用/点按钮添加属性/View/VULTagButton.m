//
//  VULTagButton.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/18.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULTagButton.h"

@interface VULTagButton (){
    UIColor *_bgColor;
}

@end

@implementation VULTagButton

- (void)setHighlighted:(BOOL)highlighted {
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.userInteractionEnabled = NO;
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

- (void)setTitle:(NSString *)title tag:(NSInteger)tag bgColor:(UIColor *)bgColor selected:(BOOL)selected{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:bgColor forState:UIControlStateNormal];
    _bgColor = bgColor;
    self.tag = tag;
    [self tagBtnSelected:selected];
}

- (void)tagBtnSelected:(BOOL)selected{
    self.selected = selected;
    if (self.selected) {
        [self setBackgroundColor:_bgColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    } else {
        [self setTitleColor:_bgColor forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderColor = _bgColor.CGColor;
    }
}

@end
