//
//  HYBGridCell.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBGridCell.h"
#import "HYBGridModel.h"
#import "UIImageView+WebCache.h"
#import "HYBImageCliped.h"


@interface HYBGridCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HYBGridModel *model;

@end

@implementation HYBGridCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.titleLabel];
  }
  
  return self;
}

- (void)configCellWithModel:(HYBGridModel *)model {
  if (model == nil) {
    return;
  }
  
  self.model = model;
  
  // 从本地读取，若有则直接使用之。
  // 由于剪裁的图片通常都不小，所以为了解决内存暴涨问题，图片不会缓存到内存中，只是临时使用
  // 这种方式带来的好处就是内存不会暴涨
  UIImage *image = [HYBImageClipedManager clipedImageFromDiskWithKey:model.url];
  if (image) {
    self.imageView.image = image;
  } else {
    __weak __typeof(self) weakSelf = self;
    UIImage *image = [UIImage imageNamed:@"img5.jpg"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 将剪裁后的图片记录下来，下次直接使用
        UIImage *clipedImage = [image hyb_clipToSize:weakSelf.imageView.bounds.size
                                        cornerRadius:12
                                     backgroundColor:[UIColor blackColor]
                                        isEqualScale:NO];
        // 存储到本地
        [HYBImageClipedManager storeClipedImage:clipedImage toDiskWithKey:model.url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          weakSelf.imageView.image = clipedImage;
        });
      });
    }];
  }
  
  // 采用这种方式的坏处时，要缓存已剪裁的图片，当图片较多时，会引起内存暴涨。
  // 因此建议采用上面的方式
  //if (model.clipedImage) {
  //  self.imageView.image = model.clipedImage;
  //} else {
  //  __weak __typeof(self) weakSelf = self;
  //  UIImage *image = [UIImage imageNamed:@"img5.jpg"];
  //  [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
  //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
  //
  //      // 将剪裁后的图片记录下来，下次直接使用
  //      model.clipedImage = [image hyb_clipToSize:weakSelf.imageView.bounds.size
  //                                   cornerRadius:12
  //                                backgroundColor:[UIColor blackColor]
  //                                   isEqualScale:NO];
  //
  //      dispatch_async(dispatch_get_main_queue(), ^{
  //        weakSelf.imageView.image = model.clipedImage;
  //      });
  //    });
  //  }];
  //}
  
  self.titleLabel.text = model.title;
}

@end
