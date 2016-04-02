//
//  ViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "Demo1Controller.h"
#import "HYBGridViewController.h"

#define kCellIdentifier @"GITHUB Name CoderJackyHuang"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  layout.itemSize = CGSizeMake(self.view.frame.size.width, 44);
  layout.minimumLineSpacing = 0;
  
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  [self.view addSubview:self.collectionView];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  self.collectionView.showsVerticalScrollIndicator = YES;
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:kCellIdentifier];
  
  self.datasource = @[[[Demo1Controller alloc] initWithTitle:@"生成圆角"],
                      [[HYBGridViewController alloc] initWithTitle:@"网络图片"]
                      ];
  [self.collectionView reloadData];
  self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                         forIndexPath:indexPath];
  UILabel *titleLabel = [cell.contentView viewWithTag:100];
  if (!titleLabel) {
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20,
                                  0,
                                  cell.contentView.bounds.size.width - 40,
                                  cell.contentView.bounds.size.height);
    titleLabel.tag = 100;
    [cell.contentView addSubview:titleLabel];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.frame = CGRectMake(0, cell.contentView.bounds.size.height, cell.contentView.bounds.size.width, 0.5);
    [cell.contentView addSubview:label];
  }
  
  UIViewController *vc = self.datasource[indexPath.item];
  titleLabel.text = vc.title;
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.datasource.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *vc = self.datasource[indexPath.item];
  vc.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:vc animated:YES];
}

@end
