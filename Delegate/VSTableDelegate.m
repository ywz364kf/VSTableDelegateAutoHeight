//
//  VSTableDelegate.m
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSTableDelegate.h"
#import "VSBaseViewModel.h"
#import "VSCellProtocol.h"
#import "VSSectionModelProtocol.h"
#import "VSCellModelProtocol.h"
#import "VSViewModelProtocol.h"
#import "VSRefreshView.h"
@interface VSTableDelegate ()
@property (nonatomic, strong) id<VSViewModelProtocol> viewModel;
@property (nonatomic, assign) VSRefreshView *refreshView;
@end

@implementation VSTableDelegate

- (instancetype)initWithViewModel:(id<VSViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)setViewModel:(id<VSViewModelProtocol>)viewModel {
    _viewModel = viewModel;
}

- (void)setHeadReFreshView:(VSRefreshView *)refreshView {
    _refreshView = refreshView;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell<VSCellProtocol> *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellClassName = [self.viewModel cellClassNameForRowAtIndexPath:indexPath];
    if (cellClassName.length) {
        UITableViewCell<VSCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
        return cell;
    }else {
        return [[UITableViewCell<VSCellProtocol> alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(heightForHeader)]) {
        return [sectionModel heightForHeader];
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(heightForFootView)]) {
        return [sectionModel heightForFootView];
    }
    return 0.1;
    
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(tableView:forSection:viewModel:)]) {
        [sectionModel tableView:tableView forSection:section viewModel:self.viewModel];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(viewForFooter)]) {
        return [sectionModel viewForFooter];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(viewForHeader)]) {
        return [sectionModel viewForHeader];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:indexPath.section];
    if (sectionModel) {
        id <VSCellModelProtocol> cellModel = [self.viewModel cellModelAtIndexPath:indexPath];
        if ([cellModel respondsToSelector:@selector(configureCellModelWithTableView:IndexPath:)]) {
            [cellModel configureCellModelWithTableView:tableView IndexPath:indexPath];
        }
        NSString *cellClassName = cellModel.cellClsName;
        Class cellClass = NSClassFromString(cellClassName);
        if ([cellClass conformsToProtocol:@protocol(VSCellProtocol)]) {
            height = [cellClass estimatedCellHeightForCellModel:cellModel];
            [sectionModel.cellHeightArray setObject:@(height) atIndexedSubscript:indexPath.row];
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:indexPath.section];
    if (sectionModel && sectionModel.cellHeightArray.count>indexPath.row) {
        height = [sectionModel.cellHeightArray[indexPath.row] floatValue];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell<VSCellProtocol> *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<VSCellModelProtocol> cellModel = [self.viewModel cellModelAtIndexPath:indexPath];
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:indexPath.section];
    if (cellModel && [cell respondsToSelector:@selector(tableView:configureCellModel:forRowAtIndexPath:viewModel:sectionModel:)]) {
        [cell tableView:tableView configureCellModel:cellModel forRowAtIndexPath:indexPath viewModel:self.viewModel sectionModel:sectionModel];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<VSCellProtocol> *cell = (UITableViewCell<VSCellProtocol> *)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [cell tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_refreshView) {
        [_refreshView viewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_refreshView) {
        [_refreshView viewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_refreshView) {
        [_refreshView viewDidEndDragging:scrollView];
    }
}

@end
