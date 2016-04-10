//
//  HYBVC1.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/8.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBVC1.h"
#import "HYBCell1.h"
#import "HYBVC2.h"


@implementation HYBVC1

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"优化后";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
  [tableView registerClass:[HYBCell1 class] forCellReuseIdentifier:@"xxxxxxxx"];
  tableView.rowHeight = 320;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
}

- (void)action {
  HYBVC2 *VC = [[HYBVC2 alloc] init];
  [self.navigationController pushViewController:VC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"xxxxxxxx"
                                                 forIndexPath:indexPath];
  return cell;
}



@end
