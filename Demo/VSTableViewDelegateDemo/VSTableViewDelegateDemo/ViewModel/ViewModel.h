//
//  ViewModel.h
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "VSBaseViewModel.h"

@interface ViewModel : VSBaseViewModel

- (void)loadData:(void(^)(NSArray *data))loadDataCallback;

@end
