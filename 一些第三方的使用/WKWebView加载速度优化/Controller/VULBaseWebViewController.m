//
//  VULBaseWebViewController.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "WKProcessPool+SharedProcessPool.h"
#import "VULCommon.h"
@interface VULBaseWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) CALayer *progressLayer;
@end

@implementation VULBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubViews];
    [self configViews];
}

- (void)loadWebViewWithUrlStr:(NSString *)urlStr {
    self.urlStr = urlStr;
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
    [self.webView loadRequest:request];
}

- (void)addSubViews {
    [self.view addSubview:self.webView];
    
    CGFloat originY = K_NavBar_Height;
    UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.view.frame), 2)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = HEXCOLOR(0x73B6F5).CGColor;
    [progress.layer addSublayer:layer];
    self.progressLayer = layer;
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)configViews {
    self.webView.allowsBackForwardNavigationGestures = YES;
}

#pragma mark - KVO监听网页加载i进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 2);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    }
}

#pragma mark - Delegate
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载");
    NSString *URL = webView.URL.absoluteString;
    NSLog(@"截取到URL：%@",URL);
    NSURL *url = webView.URL;
    NSString *dominStr;
    if (NSStringIsNotEmpty(self.urlStr)) {
        NSArray *arr = [self.urlStr componentsSeparatedByString:@"?"];
        dominStr = arr.firstObject;
    }
    //    if (![url.absoluteString containsString:dominStr]) {
    //        [self.webView stopLoading];
    //        VULModuleBrowsingVC *moduleBrowsing = [[VULModuleBrowsingVC alloc] init];
    //        moduleBrowsing.currentURL = webView.URL.absoluteString;
    //        [self.navigationController pushViewController:moduleBrowsing animated:YES];
    //    }
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"加载出现错误");
}



+(BOOL)nsstringIsNotEmpty:(NSString *)string {
    if (string && ![string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.processPool = [WKProcessPool shareProcessPool];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
//        _webView.UIDelegate = self;
    }
    return _webView;
}

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

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.navigationDelegate = nil;
    self.webView.UIDelegate = nil;
}

@end
