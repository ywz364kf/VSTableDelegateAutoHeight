//
//  VSSectionModelProtocol.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#ifndef VSSectionModelProtocol_h
#define VSSectionModelProtocol_h
#import <UIKit/UIKit.h>

@protocol VSCellModelProtocol;
@protocol VSViewModelProtocol;
@protocol VSSectionModelProtocol <NSObject>
@property (nonatomic, strong) NSArray *cellClassNameArray;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, strong) NSArray<id<VSCellModelProtocol>> *cellModelArray;
- (instancetype)initWithCellModelArray:(NSArray<id<VSCellModelProtocol>> *)cellModelArray;
- (NSUInteger)numberOfRows;
- (id<VSCellModelProtocol>)cellModelAtRow:(NSInteger)row;
@optional
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id<VSViewModelProtocol> viewModel;

- (NSInteger)heightForHeader;
- (UIView *)viewForHeader;
- (NSInteger)heightForFootView;
- (UIView *)viewForFooter;
- (void)configureSectionData;
- (void)tableView:(UITableView *)tableView forSection:(NSInteger)section viewModel:(id<VSViewModelProtocol>)viewModel;
@end
#endif /* VSSectionModelProtocol_h */
