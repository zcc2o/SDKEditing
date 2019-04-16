//
//  VULOptionCollectionViewCell.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/21.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULOptionCollectionViewCell.h"
#import "Masonry.h"
@interface VULOptionCollectionViewCell (){
    UIColor *_normalColor;
    UIColor *_selectedColor;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *optionLabel;

@end

@implementation VULOptionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _normalColor = [UIColor blueColor];
        _selectedColor = [UIColor whiteColor];
        [self addSubviews];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

- (void)setOptionModel:(VULExamOptionModel *)optionModel {
    _optionModel = optionModel;
    
    self.titleLabel.text = optionModel.itemStr;
    self.optionLabel.text = optionModel.optionStr;
    
    if (optionModel.selected) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.optionLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = _normalColor;
    } else {
        self.titleLabel.textColor = _normalColor;
        self.optionLabel.textColor = _normalColor;
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)addSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.optionLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
    }];
    
    [self.optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(self.titleLabel);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)optionLabel {
    if (!_optionLabel) {
        _optionLabel = [[UILabel alloc] init];
        _optionLabel.textColor = [UIColor blueColor];
        _optionLabel.font = [UIFont systemFontOfSize:14];
        _optionLabel.textAlignment = NSTextAlignmentNatural;
    }
    return _optionLabel;
}

@end
