//
//  HYBAutolayoutSupportVC.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/13.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBAutolayoutSupportVC.h"
#import "HYBALSupportCell.h"
#import "HYBALModel.h"

@implementation HYBAutolayoutSupportVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
  [tableView registerClass:[HYBALSupportCell class] forCellReuseIdentifier:@"HYBALSupportCell"];
  tableView.rowHeight = 320;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBALSupportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYBALSupportCell"
                                                           forIndexPath:indexPath];
  
  // 为了简化，这里写死！
  HYBALModel *model = nil;
  model = [[HYBALModel alloc] init];
  model.headURL = @"http://g.hiphotos.baidu.com/zhidao/pic/item/aa18972bd40735fac064c12c9c510fb30e24088a.jpg";
  model.title = @"测试能否让自动布局也能添加圆角！";
  
  cell.model = model;
  
  return cell;
}

@end
