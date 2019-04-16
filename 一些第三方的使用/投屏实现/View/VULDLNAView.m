//
//  VULDLNAView.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/3.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULDLNAView.h"
#import "UIView+EXTENSION.h"
#import "VULCommon.h"
#import <MRDLNA/MRDLNA.h>
@interface VULDLNAView () {
    BOOL _isPlaying;
}

@property (nonatomic, strong) UIVisualEffectView *bgView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UISlider *sliderbar;

@property (nonatomic, strong) UIButton *FFBtn; //快进按钮
@property (nonatomic, strong) UIButton *FRBtn; //快退按钮
@property (nonatomic, strong) UIButton *quitBtn; /**< 退出按钮 */

@property (nonatomic, strong) CLUPnPDevice *deviceModel;

@property (nonatomic, strong) MRDLNA *dlnaManager;

@end

@implementation VULDLNAView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self makeSubViewActions];
        self.dlnaManager = [MRDLNA sharedMRDLNAManager];
        [self.dlnaManager startDLNA];
    }
    return self;
}

- (void)configWithDeviceModel:(CLUPnPDevice *)model {
    self.deviceModel = model;
}

- (void)layoutSubviews {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    self.bgView.frame = self.bounds;
    
    y = 80;
    width = 50;
    height = 50;
    self.playBtn.frame = CGRectMake(x, y, width, height);
    self.playBtn.centerX = self.centerX;
    
    width = 50;
    height = 50;
    x = self.playBtn.x - width - 10;
    y = self.playBtn.y;
    self.FRBtn.frame = CGRectMake(x, y, width, height);
    
    x = CGRectGetMaxX(self.playBtn.frame) + 10;
    y = self.playBtn.y;
    self.FFBtn.frame = CGRectMake(x, y, width, height);
    
    y = CGRectGetMaxY(self.playBtn.frame) + 20;
    width = 300;
    height = 30;
    self.sliderbar.frame = CGRectMake(x, y, width, height);
    self.sliderbar.centerX = self.centerX;
}

- (void)addSubviews {
    [self addSubview:self.bgView];
    [self addSubview:self.FRBtn];
    [self addSubview:self.playBtn];
    [self addSubview:self.FFBtn];
    [self addSubview:self.sliderbar];
    [self addSubview:self.quitBtn];
}

- (void)makeSubViewActions {
    [self.playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.sliderbar addTarget:self action:@selector(sliderbarValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.FRBtn addTarget:self action:@selector(FRBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.FFBtn addTarget:self action:@selector(FFBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.quitBtn addTarget:self action:@selector(quitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - actions
- (void)playBtnClicked:(UIButton *)sender {
    if (sender.selected) {
        //播放
        [self.dlnaManager dlnaPlay];
    } else {
        // 暂停
        [self.dlnaManager dlnaPause];
    }
    sender.selected = !sender.selected;
}

- (void)sliderbarValueChanged:(UISlider *)slider {
    CGFloat sliderValue = slider.value;
    NSInteger sec = sliderValue * self.dlnaManager.playLength;
    NSLog(@"播放进度条======>: %zd",sec);
    [self.dlnaManager seekChanged:sec];
    NSLog(@"%lf", sliderValue);
}

/// 快退按钮点击了
- (void)FRBtnClicked {
    CGFloat currentSecond = self.sliderbar.value * self.dlnaManager.playLength;
    NSInteger aimTime = currentSecond - 10;
    if (aimTime > 0) {
        [self.dlnaManager seekChanged:aimTime];
        NSLog(@"=======>播放后退到：%ld", aimTime);
    }
}

/// 快进按钮点击了
- (void)FFBtnClicked {
    CGFloat currentSecond = self.sliderbar.value * self.dlnaManager.playLength;
    NSInteger aimTime = currentSecond + 10;
    if (aimTime < self.dlnaManager.playLength) {
        [self.dlnaManager seekChanged:aimTime];
        NSLog(@"=======>播放后退到：%ld", aimTime);
    }
}

- (void)quitBtnClicked {
    //退出按钮点击了
    if (self.quitBtnClickedCallBack) {
        self.quitBtnClickedCallBack();
    }
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setTitleColor:VULGrayColor(180) forState:UIControlStateNormal];
        [_playBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_playBtn setTitle:@"播放" forState:UIControlStateSelected];
    }
    return _playBtn;
}

- (UISlider *)sliderbar {
    if (!_sliderbar) {
        _sliderbar = [[UISlider alloc] init];
    }
    return _sliderbar;
}

- (UIVisualEffectView *)bgView {
    if (!_bgView) {
        _bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    }
    return _bgView;
}

- (UIButton *)FRBtn {
    if (!_FRBtn) {
        _FRBtn = [[UIButton alloc] init];
        [_FRBtn setImage:[UIImage imageNamed:@"FR"] forState:UIControlStateNormal];
    }
    return _FRBtn;
}

- (UIButton *)FFBtn {
    if (!_FFBtn) {
        _FFBtn = [[UIButton alloc] init];
        [_FFBtn setImage:[UIImage imageNamed:@"FF"] forState:UIControlStateNormal];
    }
    return _FFBtn;
}

- (UIButton *)quitBtn {
    if (!_quitBtn) {
        _quitBtn = [[UIButton alloc] init];
        [_quitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _quitBtn;
}

@end
