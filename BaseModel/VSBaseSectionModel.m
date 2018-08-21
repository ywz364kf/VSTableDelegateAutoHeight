//
//  VSBaseSectionModel.m
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSBaseSectionModel.h"
#import "VSCellModelProtocol.h"
#import "VSViewModelProtocol.h"
#import <UIKit/UIKit.h>

@implementation VSBaseSectionModel

@synthesize cellHeightArray = _cellHeightArray;
@synthesize cellClassNameArray = _cellClassNameArray;
@synthesize cellModelArray = _cellModelArray;
@synthesize tableView = _tableView;
@synthesize section = _section;
@synthesize viewModel = _viewModel;

- (NSUInteger)numberOfRows {
    return self.cellModelArray.count;
}

- (instancetype)initWithCellModelArray:(NSArray<id<VSCellModelProtocol>> *)cellModelArray {
    self = [super init];
    if (self) {
        _cellModelArray = cellModelArray;
        _cellHeightArray = [NSMutableArray array];
        _cellClassNameArray = [NSArray array];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellModelArray = [NSMutableArray array];
        _cellHeightArray = [NSMutableArray array];
        _cellClassNameArray = [NSArray array];
    }
    return self;
}

- (void)configureSectionData {
    
}

- (UITableView *)tableView {
    return _tableView;
}

- (NSInteger)section {
    return _section;
}

- (id<VSViewModelProtocol>)viewModel {
    return _viewModel;
}

- (NSArray<id<VSCellModelProtocol>> *)cellModelArray {
    return _cellModelArray;
}

- (NSMutableArray *)cellHeightArray {
    return _cellHeightArray;
}

- (NSArray *)cellClassNameArray {
    return _cellClassNameArray;
}

- (id<VSCellModelProtocol>)cellModelAtRow:(NSInteger)row {
    if (row >= 0 && row < [self numberOfRows]) {
        return self.cellModelArray[row];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView forSection:(NSInteger)section viewModel:(id<VSViewModelProtocol>)viewModel {
    self.tableView = tableView;
    self.section = section;
    self.viewModel = viewModel;
    [self configureSectionData];
}


@end
