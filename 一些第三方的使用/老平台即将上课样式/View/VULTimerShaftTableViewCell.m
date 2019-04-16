//
//  VULTimerShaftTableViewCell.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/23.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULTimerShaftTableViewCell.h"
#import "VULCommon.h"
#import "Masonry.h"
#define livingColor VULRGBColor(255, 35, 54)
#define willLivingTodayColor VULRGBColor(255, 154, 68)
#define willLivingColor DefaultColor
#define livedColor VULGrayColor(191)

@interface VULTimerShaftTableViewCell ()

@property (nonatomic, strong) UILabel *statusLabel; /**< 上课状态  正在上课 已结束。即将开始 等*/
@property (nonatomic, strong) UIView *topHalfLineView; /**< 上半时间轴灰线 */
@property (nonatomic, strong) UIView *statusCircleView; /**< 状态圆点 红色正在直播 灰色已结束  一天后 蓝色  一天内橙色 */
@property (nonatomic, strong) UIView *bottomHalfLineView; /**< 下半时间轴灰线 */
@property (nonatomic, strong) UIButton *liveBtn; /**< 直播按钮 直播课时显示 */
@property (nonatomic, strong) UILabel *courseInfoLabel; /**< 直播课内容 */

@end

@implementation VULTimerShaftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    [self addSubview:self.statusLabel];
    [self addSubview:self.topHalfLineView];
    [self addSubview:self.statusCircleView];
    [self addSubview:self.bottomHalfLineView];
    [self addSubview:self.liveBtn];
    [self addSubview:self.courseInfoLabel];
    
    CGFloat space = 10;
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(space);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    [self.topHalfLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.statusLabel.mas_right).offset(15);
        make.width.mas_equalTo(2);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.statusCircleView.mas_top);
    }];
    
    [self.statusCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topHalfLineView.mas_centerX);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.bottomHalfLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topHalfLineView.mas_centerX);
        make.top.mas_equalTo(self.statusCircleView.mas_bottom);
        make.width.mas_equalTo(2);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.topHalfLineView.mas_right).offset(15);
        if (IS_IPAD) {
            make.width.mas_equalTo(80);
        } else {
            make.width.mas_equalTo(60);
        }
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.courseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.liveBtn.mas_right).offset(5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.layer.cornerRadius = 4;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.numberOfLines = 0;
        _statusLabel.font = VULPingFangSCMedium(15);
    }
    return _statusLabel;
}

- (UIView *)topHalfLineView {
    if (!_topHalfLineView) {
        _topHalfLineView = [[UIView alloc] init];
        _topHalfLineView.backgroundColor = VULGrayColor(232);
    }
    return _topHalfLineView;
}

- (UIView *)statusCircleView {
    if (!_statusCircleView) {
        _statusCircleView = [[UIView alloc] init];
        _statusCircleView.backgroundColor = [UIColor clearColor];
        _statusCircleView.layer.cornerRadius = 3;
        _statusCircleView.layer.masksToBounds = YES;
        _statusCircleView.layer.borderWidth = 2;
        _statusCircleView.layer.borderColor = livedColor.CGColor;
    }
    return _statusCircleView;
}

- (UIView *)bottomHalfLineView {
    if (!_bottomHalfLineView) {
        _bottomHalfLineView = [[UIView alloc] init];
        _bottomHalfLineView.backgroundColor = VULGrayColor(232);
    }
    return _bottomHalfLineView;
}

- (UIButton *)liveBtn {
    if (!_liveBtn) {
        _liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _liveBtn.titleLabel.font = VULPingFangSCMedium(16);
        _liveBtn.layer.cornerRadius = 4;
        _liveBtn.layer.masksToBounds = YES;
        [_liveBtn setBackgroundColor:VULRGBColor(56, 197, 52)];
        [_liveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _liveBtn;
}

- (UILabel *)courseInfoLabel {
    if (!_courseInfoLabel) {
        _courseInfoLabel = [[UILabel alloc] init];
        _courseInfoLabel.font = VULPingFangSCMedium(15);
        _courseInfoLabel.textColor = VULGrayColor(190);
        _courseInfoLabel.numberOfLines = 0;
    }
    return _courseInfoLabel;
}

@end
