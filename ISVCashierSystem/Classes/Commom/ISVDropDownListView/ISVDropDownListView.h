//
//  ISVDropDownListView.h
//  ISV
//
//  Created by aaaa on 15/12/2.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISVDropDownChooseDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
- (NSInteger)defaultShowSection:(NSInteger)section;

@end

@protocol ISVDropDownChooseDelegate <NSObject>

@optional
// 选择一个会触发
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end


// 新增下拉菜单
@interface ISVDropDownListView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentExtendSection; //当前展开的section，默认－1时，表示都没有展开
@property (nonatomic, assign) CGFloat dropDownMaxHeight;
@property (nonatomic, assign) id<ISVDropDownChooseDataSource> dataSource;
@property (nonatomic, assign) id<ISVDropDownChooseDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<ISVDropDownChooseDataSource>)datasource delegate:(id<ISVDropDownChooseDelegate>)delegate;

- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
