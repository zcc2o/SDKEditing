//
//  VULPushViewController.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/10.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULPushViewController.h"
#import "LFLiveSession.h"
#import "VULCommon.h"

@interface VULPushViewController ()<LFLiveSessionDelegate>

@property (nonatomic, strong) LFLiveStreamInfo *stream;
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, strong) UIView *videoView;

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation VULPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: self.pushBtn];
    
    [self.view addSubview:self.videoView];
    
//    [self demoMethod];
}

- (void)pushBtnClicked:(UIButton *)sender {
    if (sender.selected) {
        [self.session stopLive];
    } else {
        //rtmp://video-center.alivecdn.com/xx/5836751715431547981653523c?vhost=a1.wxbig.cn&auth_key=2147483647-0-0-b3687949334384f4b7af103cf81ee7bf
//        self.stream.url = @"rtmp://video-center.alivecdn.com/xx/5836751715431547981653523c?vhost=a1.wxbig.cn&auth_key=2147483647-0-0-b3687949334384f4b7af103cf81ee7bf";//摄像头
        self.stream.url = @"rtmp://video-center.alivecdn.com/xx/5836751715431547981653523s?vhost=a1.wxbig.cn&auth_key=2147483647-0-0-8091dab118e2c3bf3fa65926bdd3740b";// 白板
        [self configurationSession];
    }
    sender.selected = !sender.selected;
}

- (void)configurationSession {
    if(!_session) {
        LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration defaultConfigurationForQuality:LFLiveAudioQuality_High];
        LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3 outputImageOrientation:UIInterfaceOrientationPortrait];
        //    videoConfiguration.videoSizeRespectingAspectRatio = YES;
//        videoConfiguration.videoSize = CGSizeMake( 640, 480);
        LFLiveSession *session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration captureType:LFLiveCaptureDefaultMask];
        self.session = session;
    }
    self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    self.session.beautyFace = YES;
    self.session.delegate = self;
    self.session.showDebugInfo = NO;
    self.session.muted = NO;
    self.session.preView = self.videoView;
    self.session.mirror = NO;
    [self.session setRunning:YES];
    [self.session startLive:self.stream];
}

#pragma mark - LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    NSLog(@"liveStateDidChange: %ld", (unsigned long)state);
    switch (state) {
        case LFLiveReady:
            NSLog(@"未连接");
            break;
        case LFLivePending:
            NSLog(@"连接中");
//            [self showWaitHudWithString:@"连接中,请稍候"];
            break;
        case LFLiveStart:
            NSLog(@"已连接");
//            [self dissmissHudView];
//            [self makeToast:@"连接成功"];
//            self.pubClarity.hidden = NO;
//            self.cameraChange.hidden = NO;
            break;
        case LFLiveError:
            NSLog(@"连接错误");
//            [self makeToast:@"连接错误"];
            break;
        case LFLiveStop:
            NSLog(@"未连接");
//            [self makeToast:@"连接断开"];
            break;
        default:
            break;
    }
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo {
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode {
    //    NSLog(@"errorCode: %ld", errorCode);
}


- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake((VULSCREEN_WIDTH - 320) / 2, 150, 320, 240)];
        _videoView.backgroundColor = [UIColor blackColor];
    }
    return _videoView;
}

- (UIButton *)pushBtn {
    if (!_pushBtn) {
        _pushBtn = [[UIButton alloc] initWithFrame:CGRectMake((VULSCREEN_WIDTH - 80) / 2, 70, 80, 40)];
        [_pushBtn setTitle:@"开始推流" forState:UIControlStateNormal];
        [_pushBtn setTitle:@"取消推流" forState:UIControlStateSelected];
        [_pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pushBtn addTarget:self action:@selector(pushBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBtn;
}

- (LFLiveStreamInfo *)stream {
    if (!_stream) {
        _stream = [LFLiveStreamInfo new];
    }
    return _stream;
}

- (void)demoMethod {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 300, 250)];
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor redColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"ruralScene3.jpg"];
    imageView.image = image;
    // AVMakeRectWithAspectRatioInsideRect 获取一个 size在另一个view 中居中后的frame
    CGRect iamgeAspectRect = AVMakeRectWithAspectRatioInsideRect(image.size, imageView.bounds);
    NSLog(@"iamgeAspectRect = %@, imageView =%@",NSStringFromCGRect(iamgeAspectRect),NSStringFromCGRect(imageView.frame));
    [self.view addSubview:imageView];
    
}

@end
