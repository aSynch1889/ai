//
//  UIImage+HMEquale.m
//  HealthMall
//
//  Created by jkl on 16/2/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "UIImage+HMEquale.h"

@implementation UIImage (HMEquale)

- (BOOL)isEqual:(UIImage *)object
{
    NSData *d1 = UIImagePNGRepresentation(self);
    NSData *d2 = UIImagePNGRepresentation(object);
    return [d1 isEqual:d2];
}

@end
