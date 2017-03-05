//
//  HMUrlManager.m
//  HealthMall
//
//  Created by qiuwei on 15/9/18.
//  Copyright (c) 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import "HMUrlManager.h"
#import "HMUserCenter.h"
#import "NSData+AES256.h"
#import "GTMBase64.h"
#import "HMLocationTool.h"
#import "NSString+HMExtension.h"

#define kShareAESkey @"CBB963D6BADECFCDDCE5FC66222EDD41"

@implementation HMUrlManager

/**
 *  生成滴滴打车URL
 *
 *  @return 返回滴滴打车URL NSString
 */
+ (NSString *)didiTaxiUrl
{
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    
    HMUserModel *model = HMDefaultUserCenter.userModel;
    NSString *phoneNum = model.telephone;
    if (phoneNum == nil) phoneNum = @"";
    
    double latitude = [HMLocationTool shared].loction.coordinate.latitude;
    double longitude = [HMLocationTool shared].loction.coordinate.longitude;

    NSString *urlStr = [NSString stringWithFormat:@"http://webapp.diditaxi.com.cn/?channel=%zd&maptype=%@&fromlat=%f&fromlng=%f&phone=%@&schedule=%zd&scheduletime=%zd&d=%zd&biz=1",kDidiTaxichannel, @"baidu", latitude, longitude, phoneNum, 0, time, time];
    NSLog(@"%@",urlStr);
    
    return urlStr;
}

+ (NSURL *)getMyCouponUrl:(BOOL)isUse{
    
    HMUserModel *model = HMDefaultUserCenter.userModel;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/Coupon/?userID=%@&isUse=%@",URL_SHOPHOSTNAME,model.UserID,isUse==YES?@"1":@"0"];
    
    return [NSURL URLWithString:urlStr];
}

// 生成分享页URL
+ (NSString *)generateShareUrlWithType:(NSString *)type params:(NSDictionary*)params
{
    //    NSString* s = [[GTMBase64 stringByEncodingData:[[paramsJson dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:kShareAESkey]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *t = [params objectForKey:@"t"] ? [params objectForKey:@"t"] : @"";
    return [NSString stringWithFormat:@"%@/%@?s=%@&t=%@&mark=%@&k=%@",URL_SHAREHOSTNAME, type, [params objectForKey:@"s"], t,type,[params objectForKey:@"data"]];
}

/**
 *  根据路径数组返回缩略图路径数组
 */
+ (NSMutableArray *)getThumbURLsWithURLStrings:(NSArray *)URLStrings
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSString *str in URLStrings) {
        
        NSString *thumbStr = [str thumbnailURLWithString];
        if (thumbStr) {
            [images addObject:thumbStr];
        }
    }
    return images;
}
@end
