//
//  MQCommodityService.m
//  MQCashRegister
//
//  Created by Gu Jun on 3/2/16.
//  Copyright © 2016 Gu Jun. All rights reserved.
//

#import "MQCommodityService.h"

@implementation MQCommodityService

// 商品信息测试数据
- (NSDictionary *)mockCommodities
{
    NSMutableDictionary *commodities = [[NSMutableDictionary alloc] init];
    MQCommodity *cola = [[MQCommodity alloc] initWithCode:@"ITEM000001" name:@"可口可乐" quantifier:@"瓶" price:@3];
    MQCommodity *shuttlecock = [[MQCommodity alloc] initWithCode:@"ITEM000003" name:@"羽毛球" quantifier:@"个" price:@1];
    MQCommodity *apple = [[MQCommodity alloc] initWithCode:@"ITEM000005" name:@"苹果" quantifier:@"斤" price:@5.5];
    [commodities setObject:cola forKey:@"ITEM000001"];
    [commodities setObject:shuttlecock forKey:@"ITEM000003"];
    [commodities setObject:apple forKey:@"ITEM000005"];
    return [commodities copy];
}

@end
