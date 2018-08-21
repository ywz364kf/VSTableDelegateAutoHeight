//
//  GoodSectionModel.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "GoodSectionModel.h"
#import "GoodCellModel.h"
@implementation GoodSectionModel
- (instancetype)initWithGoodData:(NSArray *)goodData {
    self = [super initWithCellModelArray:[self cellModelWithData:goodData]];
    if (self) {
        
    }
    return self;
}

- (NSArray<GoodCellModel *> *)cellModelWithData:(NSArray *)historyData {
    
    NSMutableArray *goodCellModelData = [NSMutableArray array];
    for (int i =0 ; i<3; i++) {
        GoodCellModel *cellModel = [[GoodCellModel alloc] init];
        //        cellModel.data = xxxxx; 做数据填充
        [goodCellModelData addObject:cellModel];
    }
    
    return goodCellModelData;
}
@end
