//
//  UILabel+HMExtension.m
//  HealthMall
//
//  Created by jkl on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "UILabel+HMExtension.h"

@implementation UILabel (HMExtension)
- (CGSize)labelSizeWithMaxWidth:(CGFloat)maxWidth
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    
    CGSize titleSize = [self.text boundingRectWithSize:CGSizeMake(maxWidth, self.font.lineHeight)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName: self.font,
                                                          NSParagraphStyleAttributeName:paragraphStyle}
                                                context:nil].size;
    return titleSize;
}


@end
