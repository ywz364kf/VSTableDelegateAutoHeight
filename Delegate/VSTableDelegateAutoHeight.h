//
//  VSTableDelegateAutoHeight.h
//  Spec
//
//  Created by leo on 2018/3/1.
//  Copyright © 2018年 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol VSViewModelProtocol;
@interface VSTableDelegateAutoHeight : NSObject<UITableViewDelegate,
                                                UITableViewDataSource>
- (instancetype)initWithViewModel:(id<VSViewModelProtocol>)viewModel;
- (void)setViewModel:(id<VSViewModelProtocol>)viewModel;

@end
