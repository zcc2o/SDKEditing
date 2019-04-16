//
//  VULTopProgressView.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/19.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULTopProgressView.h"
#import "VULProgressView.h"
#import "UIView+EXTENSION.h"

@interface VULTopProgressView ()

@property (nonatomic, strong) NSArray *progressModels;

@end

@implementation VULTopProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// TODO: 更新控件
- (void)setProgressModels:(NSArray *)progressModels {
    _progressModels = progressModels;
    if (self.subviews.count == progressModels.count) {
        int i = 0;
        for (VULProgressView *pView in self.subviews) {
            pView.progressModel = progressModels[i];
            i ++;
        }
    }
}

// TODO: 初始化
- (void)progressViewWithArray:(NSArray<VULProgressModel *> *)progressModels {
    _progressModels = progressModels;
    CGFloat viewWidth = self.width / progressModels.count;
    for (int i = 0; i < progressModels.count; i ++) {
        VULProgressModel *model = progressModels[i];
        VULProgressView *progressView = [[VULProgressView alloc] initWithFrame:CGRectMake(viewWidth * i, 0, viewWidth, self.height)];
        [self addSubview:progressView];
        
        progressView.progressModel = model;
    }
}

@end
