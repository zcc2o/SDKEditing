//
//  VULDLNAView.h
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/3.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLUPnPDevice;

NS_ASSUME_NONNULL_BEGIN

@interface VULDLNAView : UIView

@property (nonatomic, copy) void(^quitBtnClickedCallBack)(void);

- (void)configWithDeviceModel:(CLUPnPDevice *)model;

@end

NS_ASSUME_NONNULL_END
