//
//  OrderSectionModel.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "OrderSectionModel.h"
#import "OrderCellModel.h"
@implementation OrderSectionModel
- (instancetype)initWithOrderData:(NSArray *)orderData {
    self = [super initWithCellModelArray:[self cellModelWithData:orderData]];
    if (self) {
        
    }
    return self;
}

- (NSArray<OrderCellModel *> *)cellModelWithData:(NSArray *)historyData {
    
    NSMutableArray *orderCellModelData = [NSMutableArray array];
    for (int i =0 ; i<6; i++) {
        OrderCellModel *cellModel = [[OrderCellModel alloc] init];
        //        cellModel.data = xxxxx; 做数据填充
        
        [orderCellModelData addObject:cellModel];
    }
    
    return orderCellModelData;
}
@end
