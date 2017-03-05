//
//  HMSearchResultViewController.h
//  HealthMall
//
//  Created by qiuwei on 15/12/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSearchPotocol.h"

@protocol HMSearchResultViewControllerDelegate <NSObject>

@optional

// 自定义显示搜索结果的cell
- (UITableViewCell *)searchResultWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)searchResultWithTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HMSearchResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) id<HMSearchResultViewControllerDelegate> delegate;

/**
 *  点击某个搜索结果需要执行的操作
 */
@property (nonatomic, copy) void (^resultOpreation)(id<HMSearchPotocol>imFriend);
/**
 *  存放所有搜索结果的模型数组，必须遵守HMSearchPotocol协议
 */
@property (nonatomic, strong) NSMutableArray<id<HMSearchPotocol>> *searchResults;
/**
 *  搜索条件（可多个，需要搜索的对象的属性，以字符串形式）
 */
@property (nonatomic, strong) NSArray<NSString *> *searchFiltereds;


+ (instancetype)defaultViewController;

/**
 *  传入原资源和关键词让tableViewController处理
 *
 *  @param sources    原来搜索资源
 *  @param searchText 搜索的关键词
 */
- (void)searchResultsUpdateWithSources:(NSArray<id<HMSearchPotocol>> *)sources searchText:(NSString *)searchText;


@end
