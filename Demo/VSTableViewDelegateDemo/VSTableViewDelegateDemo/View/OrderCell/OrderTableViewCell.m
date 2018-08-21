//
//  OrderTableViewCell.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderCellModel.h"
@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellModel {
    // 数据加载
    if ([self.cellModel isKindOfClass:[OrderCellModel class]]) {
        //拿到数据模型做数据加载
    }
}
@end
