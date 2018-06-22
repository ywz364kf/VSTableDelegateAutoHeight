//
//  VSCellProtocol.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#ifndef VSCellProtocol_h
#define VSCellProtocol_h

@protocol VSCellModelProtocol;
@protocol VSViewModelProtocol;
@protocol VSSectionModelProtocol;
@protocol VSCellProtocol <NSObject>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) id<VSCellModelProtocol> cellModel;
@property (nonatomic, weak) id<VSViewModelProtocol> viewModel;
@property (nonatomic, weak) id<VSSectionModelProtocol> sectionModel;

+ (CGFloat)estimatedCellHeightForCellModel:(id<VSCellModelProtocol>)cellModel;

- (void)tableView:(UITableView *)tableView configureCellModel:(id<VSCellModelProtocol>)cellModel forRowAtIndexPath:(NSIndexPath *)indexPath viewModel:(id<VSViewModelProtocol>)viewModel sectionModel:(id<VSSectionModelProtocol>)sectionModel;

@optional

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//固定高度
- (CGFloat)cellFixedHeight;
@end

#endif /* VSCellProtocol_h */
