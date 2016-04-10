//
//  HYBVC2.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/8.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBVC2.h"
#import "HYBCell2.h"

@implementation HYBVC2

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"优化前";
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
  [tableView registerClass:[HYBCell2 class] forCellReuseIdentifier:@"xxxxxxxx"];
  tableView.rowHeight = 210;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"xxxxxxxx"
                                                   forIndexPath:indexPath];
  return cell;
}


@end
