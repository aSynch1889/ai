//
//  HMOrderHeaderInfoView.h
//  HealthMall
//
//  Created by healthmall005 on 15/12/1.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMOrderHeaderInfoModel.h"

@protocol HMOrderHeaderInfoViewDelegate <NSObject>

- (void)didUserTapIcon:(UITapGestureRecognizer *)tap userid:(NSString *)userid;

@end

@interface HMOrderHeaderInfoView : UIView<UIActionSheetDelegate>

@property (nonatomic, strong) HMOrderHeaderInfoModel* model;//头部视图model

@property (nonatomic, weak) id<HMOrderHeaderInfoViewDelegate> delegate;
@end
