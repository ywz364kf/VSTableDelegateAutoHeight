//
//  VSCellModelProtocol.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#ifndef VSCellModelProtocol_h
#define VSCellModelProtocol_h

@protocol VSCellModelProtocol <NSObject>
@optional
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) NSIndexPath *indexPath;
- (NSString *)cellClsName;
- (void)configureCellModelWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end

#endif /* VSCellModelProtocol_h */
