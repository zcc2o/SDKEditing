//
//  VULFirstWKWebViewController.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULFirstWKWebViewController.h"
#import "VULSecondWebViewController.h"
#import "PAWebView.h"

@interface VULFirstWKWebViewController ()<PAWKScriptMessageHandler>

@property (nonatomic, strong) PAWebView *webView;

@end

@implementation VULFirstWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self loadWebViewWithUrlStr:@"https://book.xx.cn/aroom/#/school/teaching/answer/details/305316"];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    _webView = [PAWebView shareInstance];
    
//    [self loadWebViewWithUrlStr: @"https://book.xx.cn/aroom/#/school/teaching/answer/details/305316"];
//    [self loadWebViewWithUrlStr:@"https://book.xx.cn/aroom/#/school/teaching/attendance/courselist"];
    [self loadWebViewWithUrlStr:@"https://book.xx.cn/myroom/#/school/teaching/answer/list"];
                                                                   
    [self.navigationController pushViewController:_webView animated:YES];
    
}

- (void)rightBtnClicked {
    VULSecondWebViewController *webViewController = [[VULSecondWebViewController alloc] init];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)loadWebViewWithUrlStr:(NSString *)urlStr {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    
    NSString *token = @"eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiLmlrDnm5vok50iLCJwbGF0Zm9ybUlkIjoyMDMsImV4cCI6MTYxNzg2NjM4MiwidXNlcklkIjo1ODMsImlhdCI6MTU1NDc5NDM4Mn0.bgG8kFbnV3ztRSTWoi2KvXiFPjzQbuPjqWCMQULtzsA";
    [properties setObject:@"token" forKey:NSHTTPCookieName];
    [properties setObject:token forKey:NSHTTPCookieValue];
    [properties setObject:[URL host] forKey:NSHTTPCookieDomain];
    [properties setObject:[URL path] forKey:NSHTTPCookiePath];
    [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *ebhcookie = [NSHTTPCookie cookieWithProperties:properties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:ebhcookie];
    [request addValue:[self readCurrentCookieWith:properties] forHTTPHeaderField:@"Cookie"];
    [request setValue:token forHTTPHeaderField:@"token"];
    
//    NSString *encodingUrlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodingUrlStr]];
    [self.webView loadRequestURL:request];
}

/*
- (void)addSubViews {
    [self.view addSubview:self.webView];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.processPool = [WKProcessPool shareProcessPool];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    }
    return _webView;
}
 */
- (NSString*)readCurrentCookieWith:(NSDictionary*)dic {
    if (dic == nil) {
        return nil;
    } else {
        NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSMutableString *cookieString = [[NSMutableString alloc] init];
        for (NSHTTPCookie*cookie in [cookieJar cookies]) {
            [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
        }
        //删除最后一个“；”
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
        return cookieString;
    }
}


@end
