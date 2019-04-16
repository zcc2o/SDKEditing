//
//  VULTeacherDeliverQuestionView.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/21.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULTeacherDeliverQuestionView.h"
#import "VULCommon.h"
#import "VULOptionCollectionViewCell.h"
#import "Masonry.h"
#define fSpacing 10
@interface VULTeacherDeliverQuestionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segmentControl; /**< 单选多选 */
@property (nonatomic, strong) UICollectionView *optionsCollectionView; /**< 选项collectionView */
@property (nonatomic, strong) NSArray *optionsModelArray; /**< 选择题选项数组 */
@property (nonatomic, strong) UIButton *diliverBtn; /**< 提交按钮 */
@property (nonatomic, strong) UILabel *explainLabel; /**< 说明文字 */

@end

static NSString *optionCellIdentifier = @"optionCellIdentifier";

@implementation VULTeacherDeliverQuestionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubViews];
        [self configSubviewsAction];
        [self loadData];
    }
    return self;
}

- (void)configSubviewsAction {
    [_segmentControl addTarget:self action:@selector(segmentControlClicked) forControlEvents:UIControlEventValueChanged];
    [_diliverBtn addTarget:self action:@selector(diliverBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击事件
// TODO:分段控制器被点击
- (void)segmentControlClicked {
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
        {
            //单选
            
        }
            break;
        case 1:
        {
            //多选
            
        }
            break;
        default:
            break;
    }
}

- (void)loadData {
    [self.optionsCollectionView reloadData];
}

// TODO:发布按钮事件
- (void)diliverBtnClicked {
    
}

#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.optionsModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VULExamOptionModel *optionModel = self.optionsModelArray[indexPath.row];
    VULOptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:optionCellIdentifier forIndexPath:indexPath];
    cell.optionModel = optionModel;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (VULSCREEN_WIDTH_VARIABLE - fSpacing * 4) / 3;
    return CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VULExamOptionModel *formalModel;
    for (int i = 0; i < self.optionsModelArray.count; i ++) {
        formalModel = self.optionsModelArray[i];
        if (formalModel.selected) {
            if (i == indexPath.row) {
                return ;
            } else {
                formalModel.selected = NO;
                [self.optionsCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
                break;
            }
        }
    }
    VULExamOptionModel *examOptionModel = self.optionsModelArray[indexPath.row];
    examOptionModel.selected = YES;
    [self.optionsCollectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)addSubViews {
    self.backgroundColor = VULGrayColor(245);
    
    [self addSubview: self.segmentControl];
    [self addSubview: self.optionsCollectionView];
    [self addSubview: self.diliverBtn];
    [self addSubview:self.explainLabel];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(30);
        make.trailing.mas_equalTo(self).offset(-30);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    CGFloat width = (VULSCREEN_WIDTH - fSpacing * 4) / 3;
    [self.optionsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.segmentControl.mas_bottom).offset(10);
        make.height.mas_equalTo(width * 2 + fSpacing * 3);
    }];
    
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(200);
    }];
    
    [self.diliverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.explainLabel.mas_top).offset(-20);
        make.width.mas_equalTo(200);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

- (NSArray *)optionsModelArray {
    if (!_optionsModelArray) {
        VULExamOptionModel *twoOptionModel = [[VULExamOptionModel alloc] init];
        twoOptionModel.itemStr = @"二选项";
        twoOptionModel.optionStr = @"AB";
        twoOptionModel.optionNum = 2;
        
        VULExamOptionModel *threeOptionModel = [[VULExamOptionModel alloc] init];
        threeOptionModel.itemStr = @"三选项";
        threeOptionModel.optionStr = @"ABC";
        threeOptionModel.optionNum = 3;
        
        VULExamOptionModel *fourOptionModel = [[VULExamOptionModel alloc] init];
        fourOptionModel.itemStr = @"四选项";
        fourOptionModel.optionStr = @"ABCD";
        fourOptionModel.optionNum = 4;
        
        VULExamOptionModel *fiveOptionModel = [[VULExamOptionModel alloc] init];
        fiveOptionModel.itemStr = @"五选项";
        fiveOptionModel.optionStr = @"ABCDE";
        fiveOptionModel.optionNum = 5;
        
        VULExamOptionModel *sixOptionModel = [[VULExamOptionModel alloc] init];
        sixOptionModel.itemStr = @"三选项";
        sixOptionModel.optionStr = @"ABCDEF";
        sixOptionModel.optionNum = 6;
        
        _optionsModelArray = [NSArray arrayWithObjects:twoOptionModel, threeOptionModel, fourOptionModel, fiveOptionModel, sixOptionModel, nil];
    }
    return _optionsModelArray;
}

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        NSArray *array = [NSArray arrayWithObjects:@"单选题", @"多选题", nil];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    }
    return _segmentControl;
}

- (UICollectionView *)optionsCollectionView {
    if (!_optionsCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = fSpacing;
        flowLayout.minimumInteritemSpacing = fSpacing;
        CGFloat width = (VULSCREEN_WIDTH - fSpacing * 4) / 3;
        flowLayout.itemSize = CGSizeMake(width, width);
        flowLayout.sectionInset = UIEdgeInsetsMake(fSpacing, fSpacing, fSpacing, fSpacing);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _optionsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_optionsCollectionView registerClass:[VULOptionCollectionViewCell class] forCellWithReuseIdentifier:optionCellIdentifier];
        _optionsCollectionView.delegate = self;
        _optionsCollectionView.dataSource = self;
        _optionsCollectionView.backgroundColor = VULGrayColor(245);
        _optionsCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _optionsCollectionView;
}

- (UIButton *)diliverBtn {
    if (!_diliverBtn) {
        _diliverBtn = [[UIButton alloc] init];
        _diliverBtn.layer.cornerRadius = 4;
        _diliverBtn.layer.masksToBounds = YES;
        [_diliverBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_diliverBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_diliverBtn setBackgroundColor:DefaultTextColor];
    }
    return _diliverBtn;
}

- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] init];
        _explainLabel.textColor = VULGrayColor(180);
        _explainLabel.font = VULPingFangSCMedium(14);
        _explainLabel.text = @"本功能只提供答题卡，题干部分建议写在文档或语言描述";
        _explainLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _explainLabel;
}

@end
