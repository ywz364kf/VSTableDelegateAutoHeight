//
//  HistorySectionModel.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "HistorySectionModel.h"
#import "HistoryCellModel.h"
@implementation HistorySectionModel
- (instancetype)initWithHistoryData:(NSArray *)historyData {
    self = [super initWithCellModelArray:[self cellModelWithData:historyData]];
    if (self) {
        
    }
    return self;
}

- (NSArray<HistoryCellModel *> *)cellModelWithData:(NSArray *)historyData {
    
    NSMutableArray *historyCellModelData = [NSMutableArray array];
    for (int i =0 ; i<5; i++) {
        HistoryCellModel *cellModel = [[HistoryCellModel alloc] init];
//        cellModel.data = xxxxx; 做数据填充
        
        [historyCellModelData addObject:cellModel];
    }
    
    return historyCellModelData;
}
@end
