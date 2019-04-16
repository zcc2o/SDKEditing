//
//  ZCCFLGIFViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ZCCFLGIFViewController.h"
#import "FLAnimatedImage.h"
#import "NSString+EXTENSION.h"
#import "UIImageView+WebCache.h"
@interface ZCCFLGIFViewController ()

@property (nonatomic, strong) FLAnimatedImageView *gifIconImageView;/**< gif头像 如果是gif就加到图层上去 */

@end

@implementation ZCCFLGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.gifIconImageView];
    _gifIconImageView.frame = CGRectMake(0, self.view.frame.size.height / 2, 100, 120);
    //http://book.sunshine.net:890/uploads/image/2019_1/3/1546499788430_25.jpg
    //https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2381238674,588426950&fm=58
    NSString *iconStr = @"http://book.sunshine.net:890/uploads/image/2019_1/3/1546499788430_25.jpg";
    NSURL *iconUrl = [NSURL URLWithString:iconStr];
    if ([NSString isGifWithImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconStr]]]) {
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:iconUrl]];
        self.gifIconImageView.animatedImage = animatedImage;
    } else {
        [_gifIconImageView sd_setImageWithURL:iconUrl];//
    }
    
    
    UIButton *leaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 25)];
    [leaveBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leaveBtn setBackgroundColor:[UIColor blackColor]];
    [leaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaveBtn addTarget:self action:@selector(leaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveBtn];
}

- (void)leaveBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (FLAnimatedImageView *)gifIconImageView {
    if (!_gifIconImageView) {
        _gifIconImageView = [[FLAnimatedImageView alloc] init];
        _gifIconImageView.layer.cornerRadius = 15;
        _gifIconImageView.clipsToBounds = YES;
        _gifIconImageView.backgroundColor = [UIColor blueColor];
    }
    return _gifIconImageView;
}

@end
