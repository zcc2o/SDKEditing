//
//  VULSecondWebViewController.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULSecondWebViewController.h"

@interface VULSecondWebViewController ()

@end

@implementation VULSecondWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"https://book.xx.cn/aroom/#/school/teaching/attendance/courselist";
    [self loadWebViewWithUrlStr:str];
}


@end
