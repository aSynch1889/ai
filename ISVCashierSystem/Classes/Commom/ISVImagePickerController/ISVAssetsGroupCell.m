//
//  ISVAssetsGroupCell.m
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVAssetsGroupCell.h"

#define MARGIN 10

@implementation ISVAssetsGroupCell

+ (instancetype)groupCell:(UITableView *)tableView
{
    NSString *reusedId = @"groupCell";
    ISVAssetsGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    return cell;
}
- (void)setGroup:(ALAssetsGroup *)group
{
    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];

    //设置属性
    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger groupCount = [group numberOfAssets];
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",groupName, groupCount];
    UIImage *image =[UIImage imageWithCGImage:group.posterImage] ;
    [self.imageView setImage:image];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellHeight = self.frame.size.height - 2 *MARGIN;
    self.imageView.frame = CGRectMake(MARGIN, MARGIN, cellHeight, cellHeight);
}

@end
