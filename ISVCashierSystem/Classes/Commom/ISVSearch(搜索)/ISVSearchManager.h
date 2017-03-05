//
//  ISVSearchManager.h
//  ISV
//
//  Created by aaaa on 15/10/8.
//  Copyright © 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISVSearchPotocol.h"
#import "ISVSearchResultViewController.h"

@class ISVSearchManager;

@protocol ISVSearchManagerDelegate <NSObject>

@optional

- (void)willShowSearchManager:(ISVSearchManager *)searchManager;
- (void)didShowSearchManager:(ISVSearchManager *)searchManager;
- (void)willHideSearchManager:(ISVSearchManager *)searchManager;
- (void)didHideSearchManager:(ISVSearchManager *)searchManager;

@end

@interface ISVSearchManager : NSObject

@property (nonatomic, weak) id<ISVSearchManagerDelegate> delegate;

/**
 *  存放所有的搜索资源的模型数组，必须遵守ISVSearchPotocol协议
 */
@property (nonatomic, strong) NSArray<id<ISVSearchPotocol>> *searchSource;
/**
 *  搜索条件（可多个，需要搜索的对象的属性，以字符串形式）
 *  如果searchSource不为空，searchFiltereds也不能为空
 */
@property (nonatomic, strong) NSArray<NSString *> *searchFiltereds;
/**
 *  点击某个搜索结果需要执行的操作
 */
@property (nonatomic, copy) void (^resultOpreation)(id<ISVSearchPotocol> obj);

/**
 *  显式激活搜索控件
 */
@property (nonatomic, assign, getter = isActive) BOOL active;


// 搜索条
@property (nonatomic, weak, readonly) UISearchBar *searchBar;

/**
 *  显示搜索结果的控制器
 */
@property (nonatomic, strong, readonly) ISVSearchResultViewController *searchResultViewController;


/**
 *  必须调用这个方法创建搜索对象
 *  @param viewController 当前所在的控制器
 */
+ (instancetype)managerWithViewController:(UIViewController *)viewController;

@end
