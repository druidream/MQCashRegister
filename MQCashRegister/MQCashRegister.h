//
//  MQCashRegister.h
//  收银机
//  负责向“小票模块”发送JSON数据
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import <Foundation/Foundation.h>
#import "MQReceiptGenerator.h"
#import "MQCommodityService.h"

@interface MQCashRegister : NSObject

@property (nonatomic, strong) MQReceiptGenerator *receiptGenerator;
@property (nonatomic, strong) MQDiscountPromotion *discountPromotion;
@property (nonatomic, strong) MQAdditionalItemPromotion *additionalItemPromotion;
@property (nonatomic, strong) MQCommodityService *commodityService;

- (void)checkout;

@end
