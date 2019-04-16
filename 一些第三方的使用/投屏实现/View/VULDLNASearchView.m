//
//  VULDLNASearchView.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/3.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULDLNASearchView.h"
#import "VULCommon.h"
#import <MRDLNA/MRDLNA.h>

@interface VULDLNASearchView ()<UITableViewDelegate, UITableViewDataSource, DLNADelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) NSArray *devicesArray;

@property(nonatomic,strong) MRDLNA *dlnaManager;
@end

@implementation VULDLNASearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

// 如果未选择设备投屏 那么 就调用这里 关闭投屏
- (void)stopDLNA {
    [self.dlnaManager endDLNA];
}

- (void)startSearchDevices {
    [self.dlnaManager startSearch];
}

- (void)searchDLNAResult:(NSArray *)devicesArray {
    self.devicesArray = devicesArray;
    [self.tableview reloadData];
}

- (void)layoutSubviews {
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, self.frame.size.height - 44);
}

- (void)addSubViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devicesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    CLUPnPDevice *device = self.devicesArray[indexPath.row];
    cell.textLabel.text = device.friendlyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *demoUrl = @"http://223.110.239.40:6060/cntvmobile/vod/p_cntvmobile00000000000020150518/m_cntvmobile00000000000659727681";
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.devicesArray.count) {
        CLUPnPDevice *model = self.devicesArray[indexPath.row];
        self.dlnaManager.device = model;
        self.dlnaManager.playUrl = demoUrl;
        self.dlnaManager.playLength = 2820;
        self.dlnaSearchedDeviceWithDeviceModel(model);
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"投屏设备";
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = VULGrayColor(64);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (MRDLNA *)dlnaManager {
    if (!_dlnaManager) {
        _dlnaManager = [MRDLNA sharedMRDLNAManager];
        _dlnaManager.delegate = self;
    }
    return _dlnaManager;
}

- (void)dealloc
{
    NSLog(@"searchView Dealloc");
}

@end
