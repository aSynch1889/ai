//
//  HMAssetsGroupController.m
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMAssetsGroupController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HMAssetsGroupCell.h"
#import "HMAssetsItemController.h"

@interface HMAssetsGroupController ()

@property (nonatomic,strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation HMAssetsGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回相册";
    self.navigationItem.backBarButtonItem = backItem;
}


#pragma mark - -----------------代理方法-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMAssetsGroupCell *cell = [HMAssetsGroupCell groupCell:tableView];
    ALAssetsGroup *group = [self.groups objectAtIndex:indexPath.row];
    cell.group = group;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HMAssetsItemController *collectionVC = [[HMAssetsItemController alloc] init];
    collectionVC.maxCount = self.maxCount;
    collectionVC.group = self.groups[indexPath.row];
    [self.navigationController pushViewController:collectionVC animated:YES];
}


#pragma mark - setter/getter 

- (ALAssetsLibrary *)assetsLibrary{
    if (_assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}
- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        dispatch_async(dispatch_get_main_queue(), ^{
            __weak typeof(self) weakSelf = self;
            [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if(group){
                    [weakSelf.groups addObject:group];
                    [weakSelf.tableView reloadData];
                }
            } failureBlock:^(NSError *error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"访问相册失败" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }];
        });
    }
    return _groups;
}


@end
