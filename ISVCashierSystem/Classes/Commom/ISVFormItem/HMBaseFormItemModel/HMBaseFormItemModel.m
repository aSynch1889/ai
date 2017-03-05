//
//  HMBaseFormItemModel.m
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormItemModel.h"
#import "HMBaseFormItemFieldView.h"
#import "HMBaseFormItemTextView.h"
#import "HMBaseFormSwitch.h"
#import "HMBaseFormItemLabel.h"

#import <MJExtension.h>

static CGFloat const kFormItemFieldViewHeight = 40.0;
static CGFloat const kFormItemTextViewHeight = 120.0;
static CGFloat const kFormItemSwitchViewHeight = 40.0;

@implementation HMBaseFormItemModel

// 实现这个方法的目的：告诉MJExtension框架HMProgramContent数组里面装的是什么模型
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"switchs" : [HMSwitch class]
             };
}

#pragma mark - 懒加载
- (CGFloat)height
{
    if (_height == 0) {
        
        if (self.formItemType == HMBaseFormItemTypeField) {
            _height = kFormItemFieldViewHeight;
        }else if(self.formItemType == HMBaseFormItemTypeText){
            _height = kFormItemTextViewHeight;
        }else if(self.formItemType == HMBaseFormItemTypeSwitch){
            _height = kFormItemSwitchViewHeight;
        }
    }
    return _height;
}

/**
 *  返回表单视图数组（带默认frame）
 */
+ (NSArray<UIView *> *)formItemViewsWithFormItemDicts:(NSArray<NSDictionary *> *)formItemDicts
{
    
    NSArray<HMBaseFormItemModel *> *formItems = [HMBaseFormItemModel objectArrayWithKeyValuesArray:formItemDicts];
    
    
    NSMutableArray<UIView *> *formItemViews = [NSMutableArray array];
    
    for (int i = 0; i < formItems.count; i++) {
        
        // 取出模型
        HMBaseFormItemModel *formItem = formItems[i];
        
        // 根据模型创建formItemVIew
        if (formItem.formItemType == HMBaseFormItemTypeField) {
            
            HMBaseFormItemFieldView *fieldView = [HMBaseFormItemFieldView viewFromXib];
            fieldView.formItem = formItem;
            [formItemViews addObject:fieldView];
            
        }else if(formItem.formItemType == HMBaseFormItemTypeText){
            
            HMBaseFormItemTextView *itemTextView = [HMBaseFormItemTextView viewFromXib];
            itemTextView.formItem = formItem;
            [formItemViews addObject:itemTextView];
            
        }else if(formItem.formItemType == HMBaseFormItemTypeSwitch){

            HMBaseFormSwitch *sw = [HMBaseFormSwitch viewFromXib];
            formItem.switchs = [HMSwitch objectArrayWithKeyValuesArray:formItem.switchs];
            sw.formItem = formItem;
            [formItemViews addObject:sw];
            
        }else if(formItem.formItemType == HMBaseFormItemTypeLabel){
            
            HMBaseFormItemLabel *itemLabel = [HMBaseFormItemLabel viewFromXib];
            itemLabel.formItem = formItem;
            [formItemViews addObject:itemLabel];
        }
    }
    return formItemViews;
}

@end
