//
//  MQCashRegister.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQCashRegister.h"
#import "MQReceipt.h"
#import "MQCommodity.h"

@implementation MQCashRegister
@synthesize receiptGenerator, discountPromotion, additionalItemPromotion, commodityService;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.receiptGenerator = [[MQReceiptGenerator alloc] init];
        self.discountPromotion = [[MQDiscountPromotion alloc] init];
        self.additionalItemPromotion = [[MQAdditionalItemPromotion alloc] init];
        self.commodityService = [[MQCommodityService alloc] init];
    }
    return self;
}

- (void)checkout
{
    // 当购买的商品中，有符合“买二赠一”优惠条件的商品时
    [self p_chechout_showcase1];
    
    // 当购买的商品中，没有符合“买二赠一”优惠条件的商品时
    [self p_chechout_showcase2];
    
    // 当购买的商品中，有符合“95折”优惠条件的商品时
    [self p_chechout_showcase3];
    
    // 当购买的商品中，有符合“95折”优惠条件的商品，又有符合“买二赠一”优惠条件的商品时
    [self p_chechout_showcase4];
}

#pragma mark - different cases
- (void)p_chechout_showcase1
{
    receiptGenerator.commodityDic = [commodityService mockCommodities];
    
    discountPromotion.promotionItems = [NSArray array];
    discountPromotion.rate = 0.95;
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000001", @"ITEM000003", nil];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [self.receiptGenerator generate:mockDataString];
    
    NSLog(@"%@", [receipt receiptText]);
}

- (void)p_chechout_showcase2
{
    receiptGenerator.commodityDic = [commodityService mockCommodities];
    
    discountPromotion.promotionItems = [NSArray array];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray array];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSLog(@"%@", [receipt receiptText]);
}

- (void)p_chechout_showcase3
{
    receiptGenerator.commodityDic = [commodityService mockCommodities];
    
    discountPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000005", nil];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray array];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSLog(@"%@", [receipt receiptText]);
}

- (void)p_chechout_showcase4
{
    receiptGenerator.commodityDic = [commodityService mockCommodities];
    
    discountPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000005",nil];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000001", @"ITEM000003", nil];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-6\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSLog(@"%@", [receipt receiptText]);
}

@end