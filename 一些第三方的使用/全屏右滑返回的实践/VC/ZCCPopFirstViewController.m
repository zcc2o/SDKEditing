//
//  ZCCPopFirstViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/2/12.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ZCCPopFirstViewController.h"
#import "ZCCPopSecondViewController.h"
#import "Masonry.h"
#import "NavigationInteractiveTransition.h"
#define VULRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define VULPingFangSCLight(fontSize) [UIFont fontWithName:@"PingFangSC-Light" size:fontSize * SCALE_FONT]
#define VULPingFangSCMedium(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * SCALE_FONT]
#define VULPingFangSCHeavy(fontSize) [UIFont fontWithName:@"PingFangSC-Heavy" size:fontSize * SCALE_FONT]

@interface ZCCPopFirstViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NavigationInteractiveTransition *navT;

@property (nonatomic, strong) UIImageView *iconImageView; /**< 提问人头像 */
@property (nonatomic, strong) UILabel *nameLabel; /**< 提问人名字 */
@property (nonatomic, strong) UILabel *timeLabel; /**< 提问时间label */
@property (nonatomic, strong) UILabel *courseLabel; /**< 课件分类名label */

@end

@implementation ZCCPopFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VULRandomColor;
    
    UIButton *leaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 50 + 64, 120, 25)];
    [leaveBtn setTitle:@"push到d下一个控制器" forState:UIControlStateNormal];
    [leaveBtn setBackgroundColor:[UIColor blackColor]];
    [leaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaveBtn addTarget:self action:@selector(leaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveBtn];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading);
        make.top.mas_equalTo(self.view.mas_top).offset(150);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(250);
    }];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width + 100, self.view.frame.size.height);
    
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(150);
        make.leading.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(20);
    }];
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;

    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self.navigationController];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
    /*
    NSMutableArray *targets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"_targets"];
    id gestureRecognizerTarget = [targets firstObject];
    //target
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");

    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    */
    [self.backView addGestureRecognizer:popRecognizer];
    
    
    [self addSubViews];
    
}

- (void)addSubViews {
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.courseLabel];
    [self.view addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(300);
        make.leading.mas_equalTo(self.view).offset(40);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    //名字
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    //提问时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
    }];
    
    //课程分类名
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom);
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
    }];
    
    self.nameLabel.text = @"ceshice是测试测试";
    self.timeLabel.text = @"一月二月三月";
    self.courseLabel.text = @"语数外物化生语数外物化生语数外物化生语数外物化";
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"ZCCPopFirstViewController");
}

- (void)leaveBtnClicked {
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    ZCCPopSecondViewController *secondVC = [[ZCCPopSecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"navigationController.viewControllers.count: %ld --- valueForKey: %d", self.navigationController.viewControllers.count, ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue]);
    return self.navigationController.viewControllers.count != 1 && ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = VULRandomColor;
    }
    return _scrollView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = VULRandomColor;
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 15;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.backgroundColor = VULRandomColor;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.font = VULPingFangSCMedium(17);
//        _nameLabel.textColor = VULGrayColor(180);
        _nameLabel.backgroundColor = VULRandomColor;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.font = VULPingFangSCMedium(15);
//        _timeLabel.textColor = VULRandomColor;
        _timeLabel.backgroundColor = VULRandomColor;
    }
    return _timeLabel;
}

- (UILabel *)courseLabel {
    if (!_courseLabel) {
        _courseLabel = [[UILabel alloc] init];
//        _courseLabel.font = VULPingFangSCMedium(15);
//        _courseLabel.textColor = VULGrayColor(180);
        _courseLabel.backgroundColor = VULRandomColor;
    }
    return _courseLabel;
}

@end
