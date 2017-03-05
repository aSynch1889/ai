//
//  HMMenuCell.h
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMMenuCell : UITableViewCell
- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL checked;
@end
