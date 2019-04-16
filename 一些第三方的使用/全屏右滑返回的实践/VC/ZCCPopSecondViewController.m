//
//  ZCCPopSecondViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/2/13.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ZCCPopSecondViewController.h"
#define VULRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define VULRGBColor(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

@interface ZCCPopSecondViewController ()

@end

@implementation ZCCPopSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VULRandomColor;
    UIButton *leaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 60, 25)];
    [leaveBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leaveBtn setBackgroundColor:[UIColor blackColor]];
    [leaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaveBtn addTarget:self action:@selector(leaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"ZCCPopSecondViewController");
}

- (void)leaveBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
