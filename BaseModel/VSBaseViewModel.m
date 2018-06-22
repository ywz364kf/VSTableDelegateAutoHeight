//
//  VSBaseViewModel.m
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSBaseViewModel.h"
#import "VSSectionModelProtocol.h"
#import "VSCellModelProtocol.h"
@implementation VSBaseViewModel
@synthesize sectionModelArray = _sectionModelArray;
#pragma mark - <VSOrderSectionModelProtocol>

- (instancetype)init {
    self = [super init];
    if (self) {
        _sectionModelArray = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)numberOfSections {
    return self.sectionModelArray.count;
}

- (id<VSSectionModelProtocol>)sectionModelInSection:(NSInteger)section {
    if (section >= 0 && section < [self numberOfSections]) {
        id<VSSectionModelProtocol> sectionModel = self.sectionModelArray[section];
        return sectionModel;
    }
    return nil;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    id<VSSectionModelProtocol> sectionModel = [self sectionModelInSection:section];
    if (!sectionModel) {
        return 0;
    }
    if ([sectionModel respondsToSelector:@selector(numberOfRows)]) {
        return [sectionModel numberOfRows];
    }
    return 0;
}

- (id<VSCellModelProtocol>)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    id<VSSectionModelProtocol> sectionModel = [self sectionModelInSection:indexPath.section];
    if ([sectionModel respondsToSelector:@selector(cellModelAtRow:)]) {
        return [sectionModel cellModelAtRow:indexPath.row];
    }
    return nil;
}

- (NSString *)cellClassNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<VSCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([cellModel respondsToSelector:@selector(cellClsName)]) {
        return [cellModel cellClsName];
    }
    return @"";
}

@end
