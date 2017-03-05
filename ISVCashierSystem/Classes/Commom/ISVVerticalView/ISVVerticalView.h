//
//  ISVVerticalView.h
//  ISV
//
//  Created by aaaa on 15/12/15.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

// 竖向的UIView（暂时只支持图片在上，文字在下居中）
@interface ISVVerticalView : UIView
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imageView;
@end
