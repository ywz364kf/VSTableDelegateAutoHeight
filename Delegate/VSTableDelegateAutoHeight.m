//
//  VSTableDelegateAutoHeight.m
//  Spec
//
//  Created by leo on 2018/3/1.
//  Copyright © 2018年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSTableDelegateAutoHeight.h"
#import "VSBaseViewModel.h"
#import "VSCellProtocol.h"
#import "VSSectionModelProtocol.h"
#import "VSCellModelProtocol.h"
#import "VSViewModelProtocol.h"

@interface VSTableDelegateAutoHeight ()
@property (nonatomic, strong) id<VSViewModelProtocol> viewModel;
@property (nonatomic, strong) NSMutableDictionary *templateCellsByIdentifiers;

@end

@implementation VSTableDelegateAutoHeight

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

- (NSMutableDictionary *)templateCellsByIdentifiers {
    if (!_templateCellsByIdentifiers) {
        _templateCellsByIdentifiers = [NSMutableDictionary dictionary];
    }
    return _templateCellsByIdentifiers;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<VSSectionModelProtocol> sectionModel = [self.viewModel sectionModelInSection:section];
    if ([sectionModel respondsToSelector:@selector(tableView:forSection:viewModel:)]) {
        [sectionModel tableView:tableView forSection:section viewModel:self.viewModel];
    }
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
        NSString *cellClassName = cellModel.cellClsName;
        UITableViewCell<VSCellProtocol> *tempCell = [self templateCellForReuseIdentifier:cellClassName withTableView:tableView];
        if ([tempCell respondsToSelector:@selector(cellFixedHeight)]) {//固定高度
            height = [tempCell cellFixedHeight];
            [sectionModel.cellHeightArray setObject:@(height) atIndexedSubscript:indexPath.row];
        }else if (cellModel && [tempCell respondsToSelector:@selector(tableView:configureCellModel:forRowAtIndexPath:viewModel:sectionModel:)]) {
            [tempCell tableView:tableView configureCellModel:cellModel forRowAtIndexPath:indexPath viewModel:self.viewModel sectionModel:sectionModel];
            height = [self systemFittingHeightForConfiguratedCell:tempCell tableView:tableView];
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

#pragma mark calculate height Method
- (__kindof UITableViewCell<VSCellProtocol> *)templateCellForReuseIdentifier:(NSString *)identifier withTableView:(UITableView *)tableView{
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    UITableViewCell<VSCellProtocol> *templateCell = self.templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.templateCellsByIdentifiers[identifier] = templateCell;
    }
    [templateCell prepareForReuse];
    return templateCell;
}

- (CGFloat)systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell tableView:(UITableView *)tableView{
    CGFloat contentViewWidth = CGRectGetWidth(tableView.frame);
    // 这部分的高度计算来做UITableView+FDTemplateLayoutCell的框架
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    CGFloat fittingHeight = 0;
    if (contentViewWidth > 0) {
        // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
        // of growing horizontally, in a flow-layout manner.
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        
        // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        });
        
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        if (isSystemVersionEqualOrGreaterThen10_2) {
            // To avoid confilicts, make width constraint softer than required (1000)
            widthFenceConstraint.priority = UILayoutPriorityRequired - 1;

            // Build edge constraints
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
            [cell addConstraints:edgeConstraints];
        }
        
        [cell.contentView addConstraint:widthFenceConstraint];
        // Auto layout engine does its math
        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // Clean-ups
        [cell.contentView removeConstraint:widthFenceConstraint];
        if (isSystemVersionEqualOrGreaterThen10_2) {
            [cell removeConstraints:edgeConstraints];
        }
    }
    
    if (fittingHeight == 0) {
        // Try '- sizeThatFits:' for frame layout.
        // Note: fitting height should not include separator view.
        fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
    }
    
    // Still zero height after all above.
    if (fittingHeight == 0) {
        // Use default row height.
        fittingHeight = 44;
    }
    // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
    if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    return fittingHeight;
}

@end
