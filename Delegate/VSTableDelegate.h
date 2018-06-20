//
//  VSTableDelegate.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol VSViewModelProtocol;
@class VSRefreshView;
@interface VSTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithViewModel:(id<VSViewModelProtocol>)viewModel;
- (void)setViewModel:(id<VSViewModelProtocol>)viewModel;
- (void)setHeadReFreshView:(VSRefreshView *)refreshView;
@end
