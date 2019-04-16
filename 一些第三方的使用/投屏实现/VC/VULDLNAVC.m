//
//  VULDLNAVC.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/3.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULDLNAVC.h"
#import "VULDLNAView.h"
#import "VULCommon.h"
#import "VULDLNASearchView.h"

@interface VULDLNAVC ()
@property (nonatomic, strong) VULDLNAView *dlnaView;
@property (nonatomic, strong) UIButton *touBtn;
@property (nonatomic, strong) UIView *dlnaBackView;
@property (nonatomic, strong) VULDLNASearchView *searchView;
@end

@implementation VULDLNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    
    [self sendTestRequest];
}

- (void)touBtnClicked:(UIButton *)sender {
    if (!_searchView) {
        [self.view addSubview:self.dlnaBackView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dlnaBackViewTaped)];
        [self.dlnaBackView addGestureRecognizer:tapGesture];
        
        [self.view addSubview:self.searchView];
        [_searchView startSearchDevices];
        __weak typeof(self)weakSelf = self;
        self.searchView.dlnaSearchedDeviceWithDeviceModel = ^(CLUPnPDevice * _Nonnull model) {
            [weakSelf showDLANControlViewWithDevice:model];
        };
        [self showSearchDeviceView];
        return ;
    }
    
    if (sender.selected) {
        [self hideSearchDeviceView];
        //清除搜索view
        [self endSearchDeviceView];
        sender.selected = NO;
    }
}

#pragma mark - Method
// 显示搜索View
- (void)showSearchDeviceView {
    [UIView animateWithDuration:0.1 animations:^{
        self.dlnaBackView.alpha = 1;
        self.searchView.frame = CGRectMake(0, VULSCREEN_HEIGHT - 300, VULSCREEN_WIDTH, 300);
    } completion:^(BOOL finished) {
        [self.searchView startSearchDevices];
    }];
}

/// 选中了某个设备调用这里 关闭画搜索View
- (void)hideSearchDeviceView {
    [UIView animateWithDuration:0.1 animations:^{
        self.searchView.frame = CGRectMake(0, VULSCREEN_HEIGHT, VULSCREEN_WIDTH, 300);
    } completion:^(BOOL finished) {
    }];
}

- (void)removeDlnaView {
    [self.dlnaView removeFromSuperview];
    self.dlnaView = nil;
}

//销毁dlna和搜索view
- (void)endSearchDeviceView {
    [self.searchView stopDLNA];
    [self.searchView removeFromSuperview];
    self.searchView = nil;
}

/// 用户选择了一个投屏设备 隐藏搜索列表 显示控制view
- (void)showDLANControlViewWithDevice:(CLUPnPDevice *)model {
    [self hideSearchDeviceView];
    if (!_dlnaView) {
        [self.view addSubview:self.dlnaView];
        self.dlnaView.frame = CGRectMake(0, 110, VULSCREEN_WIDTH, 300);
        __weak typeof(self)weakSelf = self;
        self.dlnaView.quitBtnClickedCallBack = ^{
            [weakSelf dlnaBackViewTaped];
        };
    }
    [self.dlnaView configWithDeviceModel:model];
    //显示
    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.dlnaView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

/// 灰色按到 就直接结束投屏
- (void)dlnaBackViewTaped {
    // 删除控制列表
    [self removeDlnaView];
    //删除搜算列表
    [self hideSearchDeviceView];
    [self endSearchDeviceView];
    [self.dlnaBackView removeFromSuperview];
    self.dlnaBackView = nil;
}

/*
 显示或关闭投屏 控制层
 if (!sender.selected) {
 self.dlnaView.hidden = NO;
 [UIView animateWithDuration:0.1 animations:^{
 self.dlnaView.alpha = 1;
 }];
 } else {
 [UIView animateWithDuration:0.1 animations:^{
 self.dlnaView.alpha = 0;
 } completion:^(BOOL finished) {
 self.dlnaView.hidden = YES;
 }];
 }
 sender.selected = !sender.selected;
 */

- (void)addSubviews {
    UILabel *bgLabel = [[UILabel alloc] init];
    bgLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    bgLabel.font = [UIFont systemFontOfSize:21];
    bgLabel.frame = CGRectMake(20, 150, VULSCREEN_WIDTH - 40, 200);
    bgLabel.numberOfLines = 0;
    bgLabel.textColor = [UIColor redColor];
    [self.view addSubview:bgLabel];
    
    [self.view addSubview:self.touBtn];
    self.touBtn.frame = CGRectMake(150, 55, 75, 45);
    
//    [self.view addSubview:self.searchView];
//    self.searchView.frame = CGRectMake(0, VULSCREEN_HEIGHT, VULSCREEN_WIDTH, 300);
}

/// 允许网络权限
-(void)sendTestRequest{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:url];
    requst.HTTPMethod = @"GET";
    requst.timeoutInterval = 5;
    
    [NSURLConnection sendAsynchronousRequest:requst queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError.description) {
            NSLog(@"网络正常");
        }else{
            NSLog(@"=========>网络异常");
        }
    }];
}


- (VULDLNAView *)dlnaView {
    if (!_dlnaView) {
        _dlnaView = [[VULDLNAView alloc] init];
        _dlnaView.alpha = 0;
    }
    return _dlnaView;
}

- (UIButton *)touBtn {
    if (!_touBtn) {
        _touBtn = [[UIButton alloc] init];
        [_touBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_touBtn setTitle:@"投屏" forState:UIControlStateNormal];
        [_touBtn addTarget:self action:@selector(touBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touBtn;
}

- (VULDLNASearchView *)searchView {
    if (!_searchView) {
        _searchView = [[VULDLNASearchView alloc] initWithFrame:CGRectMake(0, VULSCREEN_HEIGHT, VULSCREEN_WIDTH, 300)];
    }
    return _searchView;
}

- (UIView *)dlnaBackView {
    if (!_dlnaBackView) {
        _dlnaBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VULSCREEN_WIDTH, VULSCREEN_HEIGHT)];
        _dlnaBackView.alpha = 0;
        _dlnaBackView.backgroundColor = VULRGBAColor(0, 0, 0, 0.6);
        _dlnaBackView.userInteractionEnabled = YES;
    }
    return _dlnaBackView;
}

@end
