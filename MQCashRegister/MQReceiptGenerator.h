//
//  MQReceiptGenerator.h
//  小票模块
//  负责计算商品的价格、数量、优惠，并最终生成结算清单
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import <Foundation/Foundation.h>
#import "MQReceipt.h"
#import "MQDiscountPromotion.h"
#import "MQAdditionalItemPromotion.h"

@interface MQReceiptGenerator : NSObject

@property (nonatomic, strong) MQDiscountPromotion *discountPromotion;
@property (nonatomic, strong) MQAdditionalItemPromotion *additionalItemPromotion;
@property (nonatomic, copy) NSDictionary *commodityDic;

- (MQReceipt *)generate:(NSString *)string;

@end
