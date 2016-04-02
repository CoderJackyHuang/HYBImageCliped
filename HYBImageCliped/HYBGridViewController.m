//
//  HYBGridViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBGridViewController.h"
#import "HYBGridCell.h"
#import "HYBGridModel.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

static NSString *cellIdentifier = @"gridcellidentifier";

@interface HYBGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation HYBGridViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.itemSize = CGSizeMake((kScreenWidth - 30) / 2, (kScreenWidth - 30) / 2 + 20);
  layout.minimumLineSpacing = 10;
  layout.minimumInteritemSpacing = 10;
  layout.sectionInset = UIEdgeInsetsMake(0, 0, 64, 0);
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                           collectionViewLayout:layout];
  [self.view addSubview:self.collectionView];
  [self.collectionView registerClass:[HYBGridCell class]
          forCellWithReuseIdentifier:cellIdentifier];
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = [UIColor blackColor];
  self.collectionView.dataSource = self;
  
  NSArray *urls = @[@"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/logo.png",
                    @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/02/multithread.png",
                    @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/%E6%94%AF%E4%BB%98%E5%AE%9D.png",
                    @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/wxpay.png",
                    @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2015/12/24456C0A-4A3F-4070-8CE6-CFFD95CEABCD-e1449149195388.jpg",
                    @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2015/12/rect-e1449149188608.jpg",
                    @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1459501986&di=9e94735d0e607bf6dfe126713cead41c&src=http://b.hiphotos.baidu.com/zhidao/pic/item/79f0f736afc37931a33cfca0eac4b74542a911e6.jpg",
                    @"http://a.hiphotos.baidu.com/zhidao/pic/item/d000baa1cd11728b9f495559cafcc3cec3fd2c61.jpg",
                    @"http://g.hiphotos.bdimg.com/wisegame/pic/item/91d3572c11dfa9ec84f4d53d61d0f703908fc1c6.jpg",
                    @"http://e.hiphotos.baidu.com/zhidao/pic/item/8435e5dde71190ef024bb3e5cc1b9d16fdfa6053.jpg",
                    @"http://g.hiphotos.baidu.com/zhidao/pic/item/aa18972bd40735fac064c12c9c510fb30e24088a.jpg",
                    @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1459520802&di=11dbe6fd712e72781eff27ddc92a9255&src=http://b.hiphotos.baidu.com/zhidao/pic/item/0ff41bd5ad6eddc460cb249b38dbb6fd526633a5.jpg"];
  int j = 0;
  for (NSUInteger i = 0; i < 60; ++i) {
    if (++j > 12) {
      j = 1;
    }
    HYBGridModel *model = [[HYBGridModel alloc] init];
    model.url = [urls objectAtIndex:j - 1];
    model.title = [NSString stringWithFormat:@"item%ld", i];
    [self.datasource addObject:model];
  }
  
  [self.collectionView reloadData];
}

- (NSMutableArray *)datasource {
  if (_datasource == nil) {
    _datasource = [[NSMutableArray alloc] init];
  }
  
  return _datasource;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                         forIndexPath:indexPath];
  HYBGridModel *model = self.datasource[indexPath.item];
  [cell configCellWithModel:model];
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.datasource.count;
}

@end
