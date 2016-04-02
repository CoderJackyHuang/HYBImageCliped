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
  
  if (model.clipedImage) {
    self.imageView.image = model.clipedImage;
  } else {
    __weak __typeof(self) weakSelf = self;
    UIImage *image = [UIImage imageNamed:@"img5.jpg"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 将剪裁后的图片记录下来，下次直接使用
        model.clipedImage = [image hyb_clipToSize:weakSelf.imageView.bounds.size
                                     cornerRadius:12
                                  backgroundColor:[UIColor blackColor]
                                     isEqualScale:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          weakSelf.imageView.image = model.clipedImage;
        });
      });
    }];
  }
  
  self.titleLabel.text = model.title;
}

@end
