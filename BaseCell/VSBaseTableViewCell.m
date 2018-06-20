//
//  VSBaseTableViewCell.m
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSBaseTableViewCell.h"
#import "VSViewModelProtocol.h"
#import "VSCellModelProtocol.h"
@implementation VSBaseTableViewCell
@synthesize cellModel = _cellModel;
@synthesize tableView = _tableView;
@synthesize indexPath = _indexPath;
@synthesize viewModel = _viewModel;
@synthesize sectionModel = _sectionModel;

+ (CGFloat)estimatedCellHeightForCellModel:(id<VSCellModelProtocol>)cellModel{
    return 0;
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}


- (void)setUpUI {
    
}

- (void)configureCellModel {
    
}

- (UIViewController *)parentViewController {
    return [[VSRouteManager defaultManager] topViewController];
}

#pragma mark - <VSOrderCellProtocol>

- (void)tableView:(UITableView *)tableView configureCellModel:(id<VSCellModelProtocol>)cellModel forRowAtIndexPath:(NSIndexPath *)indexPath viewModel:(id<VSViewModelProtocol>)viewModel sectionModel:(id)sectionModel
{
    self.tableView = tableView;
    self.cellModel = cellModel;
    self.indexPath = indexPath;
    self.viewModel = viewModel;
    self.sectionModel = sectionModel;
    [self configureCellModel];
}
@end
