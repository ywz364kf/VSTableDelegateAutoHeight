//
//  ServerHandler.h
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerHandler : NSObject

- (void)loadData:(void(^)(NSArray *data))loadDataCallback;
@end
