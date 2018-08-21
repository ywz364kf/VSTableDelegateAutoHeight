//
//  VSBaseCellModel.m
//  Spec
//
//  Created by leo on 2017/11/3.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSBaseCellModel.h"
#import <UIKit/UIKit.h>
@implementation VSBaseCellModel
@synthesize tableView = _tableView;
@synthesize indexPath = _indexPath;

- (NSString *)cellClsName {
    return @"";
}

- (void)configureCellModelWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    self.tableView = tableView;
    self.indexPath = indexPath;
}

- (UITableView *)tableView {
    return _tableView;
}

- (NSIndexPath *)indexPath {
    return _indexPath;
}

@end
