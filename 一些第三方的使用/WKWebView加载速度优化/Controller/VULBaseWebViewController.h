//
//  VULBaseWebViewController.h
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VULBaseWebViewController : UIViewController

@property (nonatomic, strong) NSString *urlStr;

- (void)loadWebViewWithUrlStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
