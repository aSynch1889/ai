//
//  UIImage+ISVEquale.m
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "UIImage+ISVEquale.h"

@implementation UIImage (ISVEquale)

- (BOOL)isEqual:(UIImage *)object
{
    NSData *d1 = UIImagePNGRepresentation(self);
    NSData *d2 = UIImagePNGRepresentation(object);
    return [d1 isEqual:d2];
}

@end
