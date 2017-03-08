//
//  collectionCodeView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/8.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionCodeView : UIView
@property(nonatomic, strong)UILabel *codeLabel;//!<条形码数字
@property(nonatomic, strong)UIImageView *codeImageView;//!<条形码
@property(nonatomic, strong)UIImageView *scanCodeImgView;//!<二维码
@property(nonatomic, strong)UIButton *setAmountBtn;//!<设置金额

- (void)viewInit;
@end
