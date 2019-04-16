//
//  ZCCAddTypeViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/18.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "ZCCAddTypeViewController.h"
#import "VULTagButton.h"
#import "UIView+EXTENSION.h"
#import "Masonry.h"
#import "MyFlowLayout.h"
#import "VULWaterFlowCollectionViewCell.h"
#import "VULTagModel.h"
#import "NSString+EXTENSION.h"

#define kScreenWidth self.view.frame.size.width

#define kScreenHeight self.view.frame.size.height

@interface ZCCAddTypeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIView *totalTagsView;

@property (nonatomic, strong) UICollectionView *selectedCollectionView; /**< 选中的类型 */

@property (nonatomic, strong) UICollectionView *collectionView; /**< 总的类型 */

@property (nonatomic, strong) NSMutableArray *totalTags;  /**< 所有的标签 */

@property (nonatomic, strong) NSMutableArray *selectedTags;  /**< 选中的标签 */

@property (nonatomic, strong) UIAlertController *addTagsController;

@end

static NSString *collectionCellIdentifier = @"collectionCellIdentifier";

static NSString *selectedCollectionCellIdentifier = @"selectedCollectionCellIdentifier";

@implementation ZCCAddTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    UIButton *leaveBtn = [[UIButton alloc] init];
    [self.view addSubview:leaveBtn];
    [leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).offset(15);
        make.top.mas_equalTo(self.view.mas_top).offset(44);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(25);
    }];
    
    [leaveBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leaveBtn setBackgroundColor:[UIColor blackColor]];
    [leaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaveBtn addTarget:self action:@selector(leaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.selectedCollectionView.contentSize.height;
        if (height > 50 && height < 200) {
            [self.selectedCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        }
    }
}

- (void)leaveBtnClicked {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1001) {
        return self.totalTags.count;
    } else if (collectionView.tag == 1002) {
        return self.selectedTags.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    VULTagModel *tagModel;
    if (collectionView.tag == 1001) {
        cellIdentifier = collectionCellIdentifier;
        tagModel = self.totalTags[indexPath.row];
    } else if (collectionView.tag == 1002) {
        cellIdentifier = selectedCollectionCellIdentifier;
        tagModel = self.selectedTags[indexPath.row];
    }
    VULWaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tagModel = tagModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSNumber *currentTypeNum;
    VULTagModel *tagModel;
    if (collectionView.tag == 1001) {
        //所有的 类型标签容器
        tagModel = self.totalTags[indexPath.row];
    } else {
        if (indexPath.row == 0) {
            //创建标签
            //弹窗方式
            [self presentViewController:self.addTagsController animated:YES completion:nil];
            return ;
        } else {
            //已选中的 类型标签容器
            tagModel = self.selectedTags[indexPath.row];
        }
    }
    [self reloadSelectedViewWithTag:tagModel];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length + string.length > 15 || [string isEqualToString:@" "]) {
        return NO;
    } else {
        return YES;
    }
}

//选中或者删除标签
- (void)reloadSelectedViewWithTag:(VULTagModel *)typeModel {
    //添加或删除标签操作
    if (![self.selectedTags containsObject:typeModel]) {
        typeModel.isSelected = YES;
        [self.selectedTags addObject:typeModel];
    }else {
        [self.selectedTags removeObject:typeModel];
        typeModel.isSelected = NO;
    }
    //横向排布
//    [(MyFlowLayout *)self.selectedCollectionView.collectionViewLayout flowLayoutWithItemHeight:35 itemModelArray:self.selectedTags];
    //纵向排布
    [(MyFlowLayout *)self.selectedCollectionView.collectionViewLayout flowLayoutWithItemWidth:35 itemModelArray:self.selectedTags];
    
    NSIndexPath *totalIndexPath = [NSIndexPath indexPathForItem:[self.totalTags indexOfObject:typeModel] inSection:0];
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadItemsAtIndexPaths:@[totalIndexPath]];
    }];
}

#pragma mark -这里需要调用接口
//通过type名 添加新type
- (void)addTypesWithNewTypeName:(NSString *)typeName {
    VULTagModel *newType = [[VULTagModel alloc] init];
    newType.tagName = typeName;
    newType.tagID = self.totalTags.count;
    newType.labelType = VULUserLabelTypeIndividuality;
    newType.isSelected = YES;
    CGSize typeSize = [typeName sizewithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    newType.labelSize = CGSizeMake(typeSize.width + 8, typeSize.height);
    [self addNewTypeModel:newType];
    
}

//添加新标签到总的collectionView上去
- (void)addNewTypeModel:(VULTagModel *)typeModel {
    [self.selectedTags addObject:typeModel];
    [(MyFlowLayout *)self.selectedCollectionView.collectionViewLayout flowLayoutWithItemHeight:35 itemModelArray:self.selectedTags];
    
    [self.totalTags addObject:typeModel];
    [(MyFlowLayout *)self.collectionView.collectionViewLayout flowLayoutWithItemHeight:35 itemModelArray:self.totalTags];
}

#pragma mark - 初始化控件
- (void)addSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.selectedCollectionView];
    [self.view addSubview:self.collectionView];
    
    [self.selectedCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10 + 88);
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.selectedCollectionView.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.selectedCollectionView.mas_leading);
        make.trailing.mas_equalTo(self.selectedCollectionView.mas_trailing);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
    }];
}

- (UIView *)totalTagsView {
    if (!_totalTagsView) {
        _totalTagsView = [[UIView alloc] init];
    }
    return _totalTagsView;
}

- (UICollectionView *)selectedCollectionView {
    if (!_selectedCollectionView) {
        MyFlowLayout *layout = [[MyFlowLayout alloc] init];
//        [layout flowLayoutWithItemHeight:35 itemModelArray:self.selectedTags];
        [layout flowLayoutWithItemWidth:35 itemModelArray:self.selectedTags];
        layout.flowLayoutType = WaterFlowLayoutTypeVertical;
        CGFloat fSpacing = 10;
        layout.minimumLineSpacing = fSpacing;
        layout.minimumInteritemSpacing = fSpacing;
        layout.sectionInset = UIEdgeInsetsMake(fSpacing, fSpacing, fSpacing, fSpacing);
        
        _selectedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 50) collectionViewLayout:layout];
        [_selectedCollectionView registerClass:[VULWaterFlowCollectionViewCell class] forCellWithReuseIdentifier:selectedCollectionCellIdentifier];
        _selectedCollectionView.tag = 1002;
        _selectedCollectionView.backgroundColor = [UIColor purpleColor];
        _selectedCollectionView.delegate = self;
        _selectedCollectionView.dataSource = self;
        [_selectedCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _selectedCollectionView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MyFlowLayout *layout = [[MyFlowLayout alloc] init];
        
        for (VULTagModel *typeModel in self.totalTags) {
            CGSize typeSize = [typeModel.tagName sizewithFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            typeModel.labelSize = CGSizeMake(typeSize.width, typeSize.width + arc4random() % 50);
        }
        //传入宽固定 hh高不固定数组
//        [layout flowLayoutWithItemWidth:80 itemHeightArray:arrmHeight];
        //传入高固定 宽不固定数组
        
        [layout flowLayoutWithItemWidth:35 itemModelArray:self.totalTags];
//        [layout flowLayoutWithItemHeight:35 itemModelArray:self.totalTags];
        layout.flowLayoutType = WaterFlowLayoutTypeVertical;
        
        //以最小间距为10计算  每行客房多少cell。纵向排布的时候
//        NSInteger nCountCell = (kScreenWidth + 10 - layout.sectionInset.left) / (nCountCell + 1);
        
        //横向排布的时候
        CGFloat fSpacing = 10;
        
        layout.minimumLineSpacing = fSpacing;
        layout.minimumInteritemSpacing = fSpacing;
        layout.sectionInset = UIEdgeInsetsMake(fSpacing, fSpacing, fSpacing, fSpacing);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight - 150) collectionViewLayout:layout];
        [_collectionView registerClass:[VULWaterFlowCollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        _collectionView.tag = 1001;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)totalTags {
    if (!_totalTags) {
        _totalTags = [[NSMutableArray alloc] init];
        for (int i = 0; i < 50; i ++) {
            VULTagModel *typeModdel = [[VULTagModel alloc] init];
            typeModdel.tagName = [NSString stringWithFormat:@"当前第%d个tag", i + 1];
            typeModdel.tagID = i;
            [_totalTags addObject:typeModdel];
        }
    }
    return _totalTags;
}

- (NSMutableArray *)selectedTags {
    if (!_selectedTags) {
        _selectedTags = [[NSMutableArray alloc] init];
        VULTagModel *addTypeModel = [[VULTagModel alloc] init];
        addTypeModel.tagName = @"添加自定义标签";
        addTypeModel.tagID = 1001;
//        CGSize labelSize = [addTypeModel.tagName sizewithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        // 纵向排布的情况
        CGSize labelSize = [addTypeModel.tagName sizewithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake(35, MAXFLOAT)];
        addTypeModel.labelSize = CGSizeMake(labelSize.width + 8, labelSize.height);
        [_selectedTags addObject:addTypeModel];
//        [_selectedTags addObject:self.totalTags.firstObject];
//        [_selectedTags addObject:self.totalTags[1]];
//        [_selectedTags addObject:self.totalTags[2]];
//        [_selectedTags addObject:self.totalTags[3]];
//        [_selectedTags addObject:self.totalTags[4]];
    }
    return _selectedTags;
}

- (UIAlertController *)addTagsController {
    if (!_addTagsController) {
        _addTagsController = [UIAlertController alertControllerWithTitle:@"添加标签" message:@"请输入您的标签内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        __weak typeof(self)weakSelf =  self;
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定标签");
//            [weakSelf.addTagsController dismissViewControllerAnimated:YES completion:nil];
            UITextField *textField = weakSelf.addTagsController.textFields[0];
            [weakSelf addTypesWithNewTypeName:textField.text];
            textField.text = @"";
        }];
        
        [_addTagsController addAction:quitAction];
        [_addTagsController addAction:confirmAction];
        
        [_addTagsController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"标签内容";
            textField.delegate = weakSelf;
        }];
    }
    return _addTagsController;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        [self.selectedCollectionView removeObserver:self forKeyPath:@"contentSize"];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
    }
}

@end
