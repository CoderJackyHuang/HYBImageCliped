//
//  HYBCell2.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/8.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCell2.h"

@implementation HYBCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self setupViews];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  return self;
}


- (void)setupViews {
  self.contentView.backgroundColor = [UIColor lightGrayColor];
  
  UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
  [self.contentView addSubview:avatarView];
avatarView.image = [UIImage imageNamed:@"img2.jpeg"];
  avatarView.layer.cornerRadius = 20;
  avatarView.layer.borderWidth = 0.5;
  avatarView.layer.borderColor = [UIColor redColor].CGColor;
  avatarView.layer.masksToBounds = YES;
  avatarView.layer.borderWidth = 0.5;
  avatarView.layer.shouldRasterize = YES;
  avatarView.layer.rasterizationScale = [UIScreen mainScreen].scale;
  
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 100, 40)];
  [button setTitle:@"button" forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"img4.jpg"] forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"img7.jpg"] forState:UIControlStateHighlighted];
  button.titleLabel.font = [UIFont systemFontOfSize:14];
  [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.contentView addSubview:button];
  button.layer.cornerRadius = 10;
  button.layer.masksToBounds = YES;
  button.layer.shouldRasterize = YES;
  button.layer.borderColor = [UIColor redColor].CGColor;
  button.layer.borderWidth = 0.5;
  button.layer.rasterizationScale = [UIScreen mainScreen].scale;
  
  UILabel *label = [[UILabel alloc] init];
  label.text = @"corner label";
  label.font = [UIFont systemFontOfSize:14];
  label.textAlignment = NSTextAlignmentCenter;
  [self.contentView addSubview:label];
  label.frame = CGRectMake(170, 10, width - 170 - 10, 40);
  label.layer.cornerRadius = 20;
  label.layer.borderWidth = 0.5;
  label.layer.borderColor = [UIColor redColor].CGColor;
  label.layer.masksToBounds = YES;
  label.layer.shouldRasterize = YES;
  label.backgroundColor = [UIColor whiteColor];
  label.layer.rasterizationScale = [UIScreen mainScreen].scale;
  
  UIButton *btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 60, width - 20, 40);
  btn.layer.cornerRadius = 20;
  btn.layer.borderWidth = 0.5;
  btn.layer.borderColor = [UIColor redColor].CGColor;
  btn.layer.masksToBounds = YES;
  btn.layer.shouldRasterize = YES;
  btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
  [btn setTitle:@"按钮1" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.backgroundColor = [UIColor whiteColor];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];

  btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 110, width - 20, 40);
  btn.layer.cornerRadius = 20;
  btn.layer.borderWidth = 0.5;
  btn.layer.borderColor = [UIColor redColor].CGColor;
  btn.layer.masksToBounds = YES;
  btn.layer.shouldRasterize = YES;
  btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
  [btn setTitle:@"按钮2" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.backgroundColor = [UIColor whiteColor];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
  
  btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 160, width - 20, 40);
  btn.layer.cornerRadius = 20;
  btn.layer.borderWidth = 0.5;
  btn.layer.borderColor = [UIColor redColor].CGColor;
  btn.layer.masksToBounds = YES;
  btn.layer.shouldRasterize = YES;
  btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
  [btn setTitle:@"按钮3" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.backgroundColor = [UIColor whiteColor];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
  
}

@end
