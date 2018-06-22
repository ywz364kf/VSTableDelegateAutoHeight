//
//  VSBaseTableViewCell.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSCellProtocol.h"

@interface VSBaseTableViewCell : UITableViewCell<VSCellProtocol>

- (void)setUpUI;

- (void)configureCellModel;

- (UIViewController *)parentViewController;

@end
