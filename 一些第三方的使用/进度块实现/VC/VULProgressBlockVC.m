//
//  VULProgressBlockVCViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/19.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULProgressBlockVC.h"
#import "VULProgressView.h"
#import "VULTopProgressView.h"
#import "UIView+EXTENSION.h"
#import "VULTeacherDeliverQuestionView.h"
#import "Masonry.h"

@interface VULProgressBlockVC ()
@property (nonatomic, strong) VULProgressView *progressView;

@property (nonatomic, strong) VULTopProgressView *topProgressView;

@property (nonatomic, strong) UITextField *textfield;

@property (nonatomic, strong) UIView *keyBoardView;
@end

@implementation VULProgressBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
    [self.progressView drawProgressViewWithStatus:NO];
    
    [self.view addSubview:self.topProgressView];
    
    VULProgressModel *model1 = [[VULProgressModel alloc] init];
    model1.stateName = @"发布问题";
    model1.state = YES;
    
    VULProgressModel *model2 = [[VULProgressModel alloc] init];
    model2.stateName = @"回答收集";
    model2.state = NO;
    
    VULProgressModel *model3 = [[VULProgressModel alloc] init];
    model3.stateName = @"公布答案";
    model3.state = NO;
    //CGRectMake(30, 200, 300, 40)
    [self.topProgressView progressViewWithArray:[NSArray arrayWithObjects:model1, model2, model3, nil]];
    
    /*
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
    _textfield.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_textfield];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"测试" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(rightViewBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _textfield.rightView = rightBtn;
    _textfield.rightViewMode = UITextFieldViewModeAlways;
    
    _keyBoardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    _keyBoardView.backgroundColor = [UIColor blueColor];
    _textfield.inputView = _keyBoardView;
    */
    
    //单选多选切换
    UILabel *chooseTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 300, 30)];
    chooseTypeLabel.text = @"选择题目类型";
    chooseTypeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:chooseTypeLabel];

    NSArray *array = [NSArray arrayWithObjects:@"单选题", @"多选题", nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    segmentControl.frame = CGRectMake(30, 290, 300, 40);
    [self.view addSubview:segmentControl];
    
    VULTeacherDeliverQuestionView *deliverQuestionView = [[VULTeacherDeliverQuestionView alloc] init];
    [self.view addSubview:deliverQuestionView];
    [deliverQuestionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(350);
        make.height.mas_equalTo(450);
    }];
}

- (void)rightViewBtnClicked:(UIButton *)rightBtn {
    if (rightBtn.selected) {
        self.textfield.inputView = nil;
    } else {
        self.textfield.inputView = _keyBoardView;
    }
    rightBtn.selected = !rightBtn.selected;
}

- (VULTopProgressView *)topProgressView {
    if (!_topProgressView) {
        _topProgressView = [[VULTopProgressView alloc] initWithFrame:CGRectMake(30, 200, 300, 40)];
    }
    return _topProgressView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (VULProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[VULProgressView alloc] initWithFrame:CGRectMake(100, 80, 150, 60)];
    }
    return _progressView;
}

@end
