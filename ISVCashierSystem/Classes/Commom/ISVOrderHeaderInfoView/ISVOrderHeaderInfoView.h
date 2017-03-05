//
//  ISVOrderHeaderInfoView.h
//  ISV
//
//  Created by ISV005 on 15/12/1.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVOrderHeaderInfoModel.h"

@protocol ISVOrderHeaderInfoViewDelegate <NSObject>

- (void)didUserTapIcon:(UITapGestureRecognizer *)tap userid:(NSString *)userid;

@end

@interface ISVOrderHeaderInfoView : UIView<UIActionSheetDelegate>

@property (nonatomic, strong) ISVOrderHeaderInfoModel* model;//头部视图model

@property (nonatomic, weak) id<ISVOrderHeaderInfoViewDelegate> delegate;
@end
