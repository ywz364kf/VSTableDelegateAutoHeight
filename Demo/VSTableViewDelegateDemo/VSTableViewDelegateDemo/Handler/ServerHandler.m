//
//  ServerHandler.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ServerHandler.h"

@implementation ServerHandler

- (void)loadData:(void(^)(NSArray *data))loadDataCallback {
    NSArray *data = @[@"1",@"2",@"3"];
    loadDataCallback?loadDataCallback(data):nil;
}
@end
