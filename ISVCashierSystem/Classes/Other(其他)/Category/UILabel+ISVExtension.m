//
//  UILabel+ISVExtension.m
//  ISV
//
//  Created by aaaa on 15/11/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "UILabel+ISVExtension.h"

@implementation UILabel (ISVExtension)
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
