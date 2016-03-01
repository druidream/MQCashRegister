//
//  MQCashRegisterTests.m
//  MQCashRegisterTests
//
//  Created by Gu Jun on 3/1/16.
//  Copyright © 2016 Gu Jun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MQReceiptGenerator.h"
#import "MQDiscountPromotion.h"
#import "MQAdditionalItemPromotion.h"
#import "MQCommodityService.h"

@interface MQCashRegisterTests : XCTestCase

@property (nonatomic, strong) MQReceiptGenerator *receiptGenerator;
@property (nonatomic, strong) MQDiscountPromotion *discountPromotion;
@property (nonatomic, strong) MQAdditionalItemPromotion *additionalItemPromotion;
@property (nonatomic, strong) MQCommodityService *commodityService;

@end

@implementation MQCashRegisterTests
@synthesize receiptGenerator, discountPromotion, additionalItemPromotion, commodityService;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.receiptGenerator = [[MQReceiptGenerator alloc] init];
    self.commodityService = [[MQCommodityService alloc] init];
    self.discountPromotion = [[MQDiscountPromotion alloc] init];
    self.additionalItemPromotion = [[MQAdditionalItemPromotion alloc] init];
    
    receiptGenerator.commodityDic = [commodityService mockCommodities];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// 当购买的商品中，有符合“买二赠一”优惠条件的商品时
- (void)testExample {
    
    discountPromotion.promotionItems = [NSArray array];
    discountPromotion.rate = 0.95;
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000001", @"ITEM000003", nil];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [self.receiptGenerator generate:mockDataString];
    
    NSString *expectedString = @"***<没钱赚商店>购物清单***\n名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：6.00(元)\n名称：羽毛球，数量：5个，单价：1.00(元)，小计：4.00(元)\n名称：苹果，数量：2斤，单价：5.50(元)，小计：11.00(元)\n----------------------\n买二赠一商品：\n名称：可口可乐，数量：1瓶\n名称：羽毛球，数量：1个\n----------------------\n总计：21.00(元)\n节省：4.00(元)\n**********************\n";
    
    XCTAssert([[receipt receiptText] isEqualToString:expectedString], @"wrong receipt text");
}

// 当购买的商品中，没有符合“买二赠一”优惠条件的商品时
- (void)testExample2 {
    
    discountPromotion.promotionItems = [NSArray array];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray array];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSString *expectedString = @"***<没钱赚商店>购物清单***\n名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)\n名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)\n名称：苹果，数量：2斤，单价：5.50(元)，小计：11.00(元)\n----------------------\n总计：25.00(元)\n**********************\n";
    
    XCTAssert([[receipt receiptText] isEqualToString:expectedString], @"wrong receipt text");
}

// 当购买的商品中，有符合“95折”优惠条件的商品时
- (void)testExample3 {
    
    discountPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000005", nil];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray array];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-5\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSString *expectedString = @"***<没钱赚商店>购物清单***\n名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)\n名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)\n名称：苹果，数量：2斤，单价：5.50(元)，小计：10.45(元)，节省0.55(元)\n----------------------\n总计：24.45(元)\n节省：0.55(元)\n**********************\n";
    
    XCTAssert([[receipt receiptText] isEqualToString:expectedString], @"wrong receipt text");
}

// 当购买的商品中，有符合“95折”优惠条件的商品，又有符合“买二赠一”优惠条件的商品时
- (void)testExample4 {
    
    discountPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000005",nil];
    receiptGenerator.discountPromotion = discountPromotion;
    
    additionalItemPromotion.promotionItems = [NSArray arrayWithObjects:@"ITEM000001", @"ITEM000003", nil];
    receiptGenerator.additionalItemPromotion = additionalItemPromotion;
    
    NSString *mockDataString = @"[\"ITEM000001-3\",\"ITEM000003-6\",\"ITEM000005-2\"]";
    MQReceipt *receipt = [receiptGenerator generate:mockDataString];
    
    NSString *expectedString = @"***<没钱赚商店>购物清单***\n名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：6.00(元)\n名称：羽毛球，数量：6个，单价：1.00(元)，小计：4.00(元)\n名称：苹果，数量：2斤，单价：5.50(元)，小计：10.45(元)，节省0.55(元)\n----------------------\n买二赠一商品：\n名称：可口可乐，数量：1瓶\n名称：羽毛球，数量：2个\n----------------------\n总计：20.45(元)\n节省：5.55(元)\n**********************\n";
    
    XCTAssert([[receipt receiptText] isEqualToString:expectedString], @"wrong receipt text");
}


@end
