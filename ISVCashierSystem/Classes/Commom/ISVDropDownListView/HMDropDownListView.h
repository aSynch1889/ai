//
//  HMDropDownListView.h
//  HealthMall
//
//  Created by qiuwei on 15/12/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMDropDownChooseDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
- (NSInteger)defaultShowSection:(NSInteger)section;

@end

@protocol HMDropDownChooseDelegate <NSObject>

@optional
// 选择一个会触发
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end


// 新增下拉菜单
@interface HMDropDownListView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentExtendSection; //当前展开的section，默认－1时，表示都没有展开
@property (nonatomic, assign) CGFloat dropDownMaxHeight;
@property (nonatomic, assign) id<HMDropDownChooseDataSource> dataSource;
@property (nonatomic, assign) id<HMDropDownChooseDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<HMDropDownChooseDataSource>)datasource delegate:(id<HMDropDownChooseDelegate>)delegate;

- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
