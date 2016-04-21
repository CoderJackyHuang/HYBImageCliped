//
//  HYBALSupportCell.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/13.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBALSupportCell.h"
#import "HYBImageCliped.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface HYBALSupportCell ()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *imgView;
@property (nonatomic, strong) UIButton    *button;

@end

@implementation HYBALSupportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.mas_equalTo(15);
      make.width.height.mas_equalTo(80);
    }];
    self.headImageView.hyb_borderColor = [UIColor lightGrayColor];
    self.headImageView.hyb_borderWidth = 1;
    [self.headImageView hyb_addCornerRadius:40];
    
    __weak __typeof(self) weakSelf = self;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"测试能不能支持自动布局来添加圆角";
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(weakSelf.headImageView.mas_right).offset(15);
      make.top.mas_equalTo(weakSelf.headImageView);
      make.right.mas_equalTo(-15);
    }];
    
    self.imgView = [[UIView alloc] init];
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(weakSelf.titleLabel);
      make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(15);
      make.height.mas_equalTo(150);
    }];
    self.imgView.hyb_borderColor = [UIColor redColor];
    self.imgView.hyb_borderWidth = 1;
    [self.imgView hyb_setImage:@"img8.jpg" cornerRadius:10 onCliped:nil];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"自动布局" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.mas_equalTo(weakSelf.titleLabel);
      make.top.mas_equalTo(weakSelf.imgView.mas_bottom).offset(15);
      make.height.mas_equalTo(40);
    }];
    
    self.button.hyb_borderWidth = 1;
    self.button.hyb_borderColor = [UIColor redColor];
    [self.button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.button hyb_addCornerRadius:10];
  }
  
  return self;
}

- (void)setModel:(HYBALModel *)model {
  if (_model != model) {
    _model = model;
    
    UIImage *holderImage = [UIImage imageNamed:@"img5.jpg"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headURL] placeholderImage:holderImage];
    
    self.titleLabel.text = model.title;
  }
}

@end
