//
//  ViewController.m
//  VSTableViewDelegateDemo
//
//  Created by leo on 2018/8/21.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "VSTableDelegateAutoHeight.h"
#import "ViewModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VSTableDelegateAutoHeight *tableDelegate;
@property (nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _viewModel = [[ViewModel alloc] init];
    _tableDelegate = [[VSTableDelegateAutoHeight alloc] initWithViewModel:_viewModel];
    
    [self setupView];
    
    [self loadData];
}

- (void)setupView {
    [self.viewModel enumerateCellClassNameswithTableView:_tableView];
    _tableView.dataSource = self.tableDelegate;
    _tableView.delegate = self.tableDelegate;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel loadData:^(NSArray *data){
        [weakSelf.tableView reloadData];
    }];
    
}


@end
