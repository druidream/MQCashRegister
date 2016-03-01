//
//  MQReceiptGenerator.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQReceiptGenerator.h"
#import "MQCommodity.h"
#import "MQDiscountPromotion.h"
#import "MQAdditionalItemPromotion.h"
#import "MQPurchasedItem.h"
#import "MQReceipt.h"

@implementation MQReceiptGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.discountPromotion = [[MQDiscountPromotion alloc] init];
        self.additionalItemPromotion = [[MQAdditionalItemPromotion alloc] init];
        self.commodityDic = [NSDictionary dictionary];
    }
    return self;
}

- (MQReceipt *)generate:(NSString *)stringInJSON
{
    NSArray *purchasedCommodities = [self p_parseJSON:stringInJSON];
    
    NSMutableArray *shoppingItems = [[NSMutableArray alloc] init];
    NSMutableArray *additionalItems = [[NSMutableArray alloc] init];
    __block float totalAmount = 0;
    __block float discount = 0;
    
    // 购买商品清单
    [purchasedCommodities enumerateObjectsUsingBlock:^(MQPurchasedItem *obj, NSUInteger idx, BOOL *stop) {
        NSString *itemCode = obj.code;
        MQCommodity *commodity = [self.commodityDic objectForKey:itemCode];
        float subtotal = obj.quantity * [commodity.price floatValue];
        
        NSMutableString *itemLine = [NSMutableString stringWithFormat:@"名称：%@，数量：%lu%@，单价：%.2f(元)", commodity.name, obj.quantity, commodity.quantifier, [commodity.price floatValue]];
        
        if ([self.additionalItemPromotion contain:itemCode]) {
            // 买赠优惠
            NSUInteger additionalItemQuantity = obj.quantity / 3;
            float subtotalAfterPromotion = (obj.quantity - additionalItemQuantity) * [commodity.price floatValue];
            float subDiscount = subtotal - subtotalAfterPromotion;
            [itemLine appendString:[NSString stringWithFormat:@"，小计：%.2f(元)", subtotalAfterPromotion]];
            [additionalItems addObject:[NSString stringWithFormat:@"名称：%@，数量：%lu%@",  commodity.name, additionalItemQuantity, commodity.quantifier]];
            totalAmount = totalAmount + subtotalAfterPromotion;
            discount = discount + subDiscount;
        } else if ([self.discountPromotion contain:itemCode]) {
            // 折扣优惠
            float subtotalAfterPromotion = subtotal * self.discountPromotion.rate;
            float subDiscount = subtotal - subtotalAfterPromotion;

            [itemLine appendFormat:@"，小计：%.2f(元)，节省%.2f(元)", subtotalAfterPromotion, subDiscount];
            
            totalAmount = totalAmount + subtotalAfterPromotion;
            discount = discount + subDiscount;
        } else {
            [itemLine appendFormat:@"，小计：%.2f(元)", subtotal];
            totalAmount = totalAmount + subtotal;
        }
        [shoppingItems addObject:itemLine];
    }];
    
    MQReceipt *receipt = [[MQReceipt alloc] init];
    receipt.shoppingItems = [shoppingItems copy];
    receipt.additionalItems = [additionalItems copy];
    receipt.totalAmount = [NSString stringWithFormat:@"总计：%.2f(元)", totalAmount];
    if (discount > 0) {
        receipt.discountAmount = [NSString stringWithFormat:@"节省：%.2f(元)", discount];
    }

    return receipt;
}

#pragma mark - private methods
// 解析JSON，返回所购买的商品集合
- (NSArray *)p_parseJSON:(NSString *)stringInJSON
{
    NSData *mockData = [stringInJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *mockDataArray = [NSJSONSerialization JSONObjectWithData:mockData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *shoppingItems = [[NSMutableArray alloc] init];
    // 解析"-"格式
    static NSString *JSONItemSeparator = @"-";
    [mockDataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *codeQuantityPair = [(NSString *)obj componentsSeparatedByString:JSONItemSeparator];
        if ([codeQuantityPair count] > 0) {
            NSString *itemCode = (NSString *)codeQuantityPair[0];
            NSUInteger itemQuantity;
            if ([codeQuantityPair count] == 1) {
                itemQuantity = 1;
            } else {
                itemQuantity = [(NSString *)codeQuantityPair[1] intValue];;
            }
            MQPurchasedItem *paidItem = [[MQPurchasedItem alloc] initWithCode:itemCode quantity:itemQuantity];
            [shoppingItems addObject:paidItem];;
        }
    }];
    return [shoppingItems copy];
}

@end
