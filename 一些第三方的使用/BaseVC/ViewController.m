//
//  ViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/9.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ViewController.h"
#import "ZCCFLGIFViewController.h"
#import "ZCCAddTypeViewController.h"
#import "ZCCPopFirstViewController.h"
#import "VULProgressBlockVC.h"
#import "VULNewCourseVC.h"
#import "VULDLNAVC.h"
#import "VULFirstWKWebViewController.h"
#import "VULPushViewController.h"
#import "BlueToothViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sdksArray;
@end

static NSString *cellIdentifier = @"cellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addViews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sdksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _sdksArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ZCCFLGIFViewController *gifVC = [[ZCCFLGIFViewController alloc] init];
            [self presentViewController:gifVC animated:YES completion:nil];
        }
            break;
        case 1:
        {
            ZCCAddTypeViewController *tagVC = [[ZCCAddTypeViewController alloc] init];
            [self.navigationController pushViewController:tagVC animated:YES];
        }
            break;
        case 2:
        {
            ZCCPopFirstViewController *popVC = [[ZCCPopFirstViewController alloc] init];
            [self.navigationController pushViewController:popVC animated:YES];
        }
            break;
        case 3:
        {
            VULProgressBlockVC *pbVC = [[VULProgressBlockVC alloc] init];
            [self.navigationController pushViewController:pbVC animated:YES];
        }
            break;
        case 4:
        {
            VULNewCourseVC *courseVC = [[VULNewCourseVC alloc] init];
            [self.navigationController pushViewController:courseVC animated:YES];
        }
            break;
        case 5:
        {
            VULDLNAVC *dlnaVC = [[VULDLNAVC alloc] init];
            [self.navigationController pushViewController:dlnaVC animated:YES];
        }
            break;
        case 6:
        {
            VULFirstWKWebViewController *wkwebView = [[VULFirstWKWebViewController alloc] init];
            [self.navigationController pushViewController:wkwebView animated:YES];
        }
            break;
            
        case 7:
        {
            VULPushViewController *pushVC = [[VULPushViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:YES];
        }
            break;
        case 8:{
            BlueToothViewController *btVC = [[BlueToothViewController alloc] init];
            [self.navigationController pushViewController:btVC animated:YES];
        }
        default:
            break;
    }
}

- (void)addViews {
    
    [self.view addSubview: self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (NSArray *)sdksArray {
    if (!_sdksArray) {
        _sdksArray = @[ @"ZCCFLGIFViewController", @"ZCCAddTypeViewController", @"ZCCPopFirstViewController", @"VULProgressBlockVC", @"VULNewCourseVC", @"VULDLNAVC", @"VULFirstWKWebViewController", @"VULPushViewController", @"BlueToothViewController.h", @"暂无"];
    }
    return _sdksArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
