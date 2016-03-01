//
//  MQCommodityService.h
//  商品service，负责提供（测试）商品数据
//  MQCashRegister
//
//  Created by Gu Jun on 3/2/16.
//  Copyright © 2016 Gu Jun. All rights reserved.
//

#import "MQPromotion.h"
#import "MQCommodity.h"

@interface MQCommodityService : MQPromotion

- (NSDictionary *)mockCommodities;

@end
