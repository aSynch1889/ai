//
//  ISVMenuCell.h
//  test
//
//  Created by ISV005 on 15/12/2.
//  Copyright © 2017年 ISV005. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVMenuCell : UITableViewCell
- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL checked;
@end
