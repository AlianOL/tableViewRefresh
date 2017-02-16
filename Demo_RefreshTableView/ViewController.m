//
//  ViewController.m
//  Demo_RefreshTableView
//
//  Created by Li on 2017/2/16.
//  Copyright © 2017年 Beijing6renyou. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    int count;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 10;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20,kDeviceWidth , kDeviceHeight-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        MJRefreshComponent *compent = [[MJRefreshComponent alloc] init];
        //        [compent beginRefreshing];
        NSLog(@"开始刷新了");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            
            
        });
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSLog(@"上拉加载");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            
        });
        
    }];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return count++;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row =%ld ",(long)indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
    
}



@end
