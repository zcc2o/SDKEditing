//
//  VULNewCourseVC.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/22.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULNewCourseVC.h"
#import "NinaPagerView.h"
#import "VULCommon.h"

@interface VULNewCourseVC ()
@property (nonatomic, strong) NinaPagerView *ninaPageView;
@end

@implementation VULNewCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

- (void)addSubViews {
    [self.view addSubview:self.ninaPageView];
}

- (NinaPagerView *)ninaPageView {
    if (!_ninaPageView) {
        NSArray *titleArr = @[@"全部问题", @"提给我的", @"我的提问", @"我的回答"];
        NSArray *vcArr = @[@"VULTeacherAnswerFirstVC", @"VULTeacherAnswerSecondVC", @"VULTeacherAnswerThirdVC", @"VULTeacherAnswerFourthVC"];
        _ninaPageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, K_NavBar_Height, VULSCREEN_WIDTH, VULSCREEN_HEIGHT - K_BottomBar_Height - K_NavBar_Height) WithTitles:titleArr WithObjects:vcArr];
        NSLog(@"%@", _ninaPageView.backgroundColor);
        _ninaPageView.showRightMargin = YES;
        _ninaPageView.backgroundColor = [UIColor whiteColor];
        _ninaPageView.ninaPagerStyles = NinaPagerStyleBottomLine;
        _ninaPageView.titleFont = 15;
        _ninaPageView.selectTitleColor = HEXCOLOR(0x73B6F5);
        _ninaPageView.underlineColor = HEXCOLOR(0x73B6F5);
        _ninaPageView.unSelectTitleColor = HEXCOLOR(0x999999);
        _ninaPageView.topTabBackGroundColor = [UIColor whiteColor];
        _ninaPageView.topTabHeight = 44;
        _ninaPageView.backgroundColor = [UIColor whiteColor];
        //一次加载所有控制器
        _ninaPageView.loadWholePages = NO;
        _ninaPageView.ninaDefaultPage = 0;
        //是否左右滑动
        _ninaPageView.nina_scrollEnabled = YES;
        _ninaPageView.selectBottomLineHeight = 3;
        _ninaPageView.titleScale = 1;
        _ninaPageView.selectBottomLinePer = 0.7;
        _ninaPageView.underLineHidden = YES;
    }
    return _ninaPageView;
}

@end
