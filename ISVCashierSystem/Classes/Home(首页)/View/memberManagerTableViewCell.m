//
//  memberManagerTableViewCell.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "memberManagerTableViewCell.h"

@implementation memberManagerTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"salesAnalysisTableViewCell";
    memberManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView setImage:[UIImage imageNamed:@"defaultIcon"]];
        self.iconView = imgView;
        
        // 1.时间
        UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kSCREEN_WIDTH-20-36-20, 34)];
        tLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:tLabel];
        self.nameLabel = tLabel;
        
        // 2.金额
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH-100-20, 11, 100, 12)];
        aLabel.font = [UIFont systemFontOfSize:12];
        
        aLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:aLabel];
        self.amountLabel = aLabel;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
