//
//  ViewModel.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewModel.h"
#import "ServerHandler.h"
#import "EventHandler.h"
#import "HistorySectionModel.h"
#import "OrderSectionModel.h"
static NSArray *CellArrayName() {
    return @[@"HistoryTableViewCell",
             @"OrderTableViewCell",
             @"GoodTableViewCell",];
}

@interface ViewModel ()

@property (nonatomic, strong) ServerHandler *serverHandler;
@property (nonatomic, strong) EventHandler *eventHandler;

@end

@implementation ViewModel

- (NSArray *)cellClassNameArray {
    return CellArrayName();
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serverHandler = [[ServerHandler alloc] init];
        _eventHandler = [[EventHandler alloc] init];
    }
    return self;
}


- (void)loadData:(void(^)(NSArray *data))loadDataCallback {
    
    [self.serverHandler loadData:^(NSArray *data){
       
        //开始组装cell的数组
        //比如显示两个section
        HistorySectionModel *historySection = [[HistorySectionModel alloc] initWithHistoryData:@[]];
        [self.sectionModelArray addObject:historySection];
        
        OrderSectionModel *orderSection = [[OrderSectionModel alloc] initWithOrderData:@[]];
        [self.sectionModelArray addObject:orderSection];
        
        loadDataCallback?loadDataCallback(data):nil;
    }];
    

}

@end
