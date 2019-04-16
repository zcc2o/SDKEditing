//
//  VULWaterFlowCollectionViewCell.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/28.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULWaterFlowCollectionViewCell.h"
#import "Masonry.h"
#import "VULTagButton.h"

@interface VULWaterFlowCollectionViewCell ()

@property (nonatomic, strong) VULTagButton *tagBtn;

@end

@implementation VULWaterFlowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.tagBtn];
        [self.tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setTagModel:(VULTagModel *)tagModel {
    _tagModel = tagModel;
    [_tagBtn setTitle:tagModel.tagName tag:tagModel.tagID bgColor:[UIColor blueColor] selected:tagModel.isSelected];
}

- (VULTagButton *)tagBtn {
    if (!_tagBtn) {
        _tagBtn = [[VULTagButton alloc] init];
    }
    return _tagBtn;
}

@end
