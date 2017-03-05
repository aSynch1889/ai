//
//  HMSearchManager.h
//  HealthMall
//
//  Created by qiuwei on 15/10/8.
//  Copyright © 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSearchPotocol.h"
#import "HMSearchResultViewController.h"

@class HMSearchManager;

@protocol HMSearchManagerDelegate <NSObject>

@optional

- (void)willShowSearchManager:(HMSearchManager *)searchManager;
- (void)didShowSearchManager:(HMSearchManager *)searchManager;
- (void)willHideSearchManager:(HMSearchManager *)searchManager;
- (void)didHideSearchManager:(HMSearchManager *)searchManager;

@end

@interface HMSearchManager : NSObject

@property (nonatomic, weak) id<HMSearchManagerDelegate> delegate;

/**
 *  存放所有的搜索资源的模型数组，必须遵守HMSearchPotocol协议
 */
@property (nonatomic, strong) NSArray<id<HMSearchPotocol>> *searchSource;
/**
 *  搜索条件（可多个，需要搜索的对象的属性，以字符串形式）
 *  如果searchSource不为空，searchFiltereds也不能为空
 */
@property (nonatomic, strong) NSArray<NSString *> *searchFiltereds;
/**
 *  点击某个搜索结果需要执行的操作
 */
@property (nonatomic, copy) void (^resultOpreation)(id<HMSearchPotocol> obj);

/**
 *  显式激活搜索控件
 */
@property (nonatomic, assign, getter = isActive) BOOL active;


// 搜索条
@property (nonatomic, weak, readonly) UISearchBar *searchBar;

/**
 *  显示搜索结果的控制器
 */
@property (nonatomic, strong, readonly) HMSearchResultViewController *searchResultViewController;


/**
 *  必须调用这个方法创建搜索对象
 *  @param viewController 当前所在的控制器
 */
+ (instancetype)managerWithViewController:(UIViewController *)viewController;

@end
