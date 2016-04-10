//
//  HYBCell1.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/8.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCell1.h"
#import "HYBImageCliped.h"

@implementation HYBCell1

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
//  [avatarView hyb_setCircleImage:@"img2.jpeg" isEqualScale:YES onCliped:nil];
  avatarView.hyb_borderColor = [UIColor redColor];
  avatarView.hyb_borderWidth = 1.0;
  [avatarView hyb_setCircleImage:@"img2.jpeg" size:CGSizeMake(40, 40) isEqualScale:YES backgrounColor:[UIColor lightGrayColor] onCliped:nil];
  
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 100, 40)];
  [button setTitle:@"button" forState:UIControlStateNormal];
  button.backgroundColor = [UIColor lightGrayColor];// 加上它
  button.hyb_borderWidth = 1;
  button.hyb_borderColor = [UIColor redColor];
  [button hyb_setBackgroundImage:@"img4.jpg" forState:UIControlStateNormal cornerRadius:10 isEqualScale:NO];
   [button hyb_setBackgroundImage:@"img7.jpg" forState:UIControlStateHighlighted cornerRadius:10 isEqualScale:YES];
  button.titleLabel.font = [UIFont systemFontOfSize:14];
  [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.contentView addSubview:button];
  
  UILabel *label = [[UILabel alloc] init];
  label.text = @"corner label";
  label.font = [UIFont systemFontOfSize:14];
  label.textAlignment = NSTextAlignmentCenter;
  [self.contentView addSubview:label];
  label.frame = CGRectMake(170, 10, width - 170 - 10, 40);
  label.hyb_borderColor = [UIColor redColor];
  label.backgroundColor = [UIColor whiteColor];
  label.hyb_borderWidth = 1;
  [label hyb_addCorner:UIRectCornerAllCorners cornerRadius:10 size:label.bounds.size backgroundColor:[UIColor lightGrayColor]];
  
  UIButton *btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 60, width - 20, 40);
  [btn setTitle:@"按钮1" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.hyb_borderWidth = 1;
  btn.hyb_borderColor = [UIColor redColor];
  btn.backgroundColor = [UIColor whiteColor];
  [btn hyb_addCorner:UIRectCornerAllCorners cornerRadius:10 size:btn.bounds.size backgroundColor:[UIColor lightGrayColor]];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
  
   btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 110, width - 20, 40);
  [btn setTitle:@"按钮2" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.hyb_borderWidth = 1;
  btn.hyb_borderColor = [UIColor redColor];
  btn.backgroundColor = [UIColor whiteColor];
  [btn hyb_addCorner:UIRectCornerAllCorners cornerRadius:10 size:btn.bounds.size backgroundColor:[UIColor lightGrayColor]];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
  
  btn = [[UIButton alloc] init];
  [self.contentView addSubview:btn];
  btn.frame = CGRectMake(10, 160, width - 20, 40);
  [btn setTitle:@"按钮3" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  btn.hyb_borderWidth = 1;
  btn.hyb_borderColor = [UIColor redColor];
  btn.backgroundColor = [UIColor whiteColor];
  [btn hyb_addCorner:UIRectCornerAllCorners cornerRadius:10 size:btn.bounds.size backgroundColor:[UIColor lightGrayColor]];
  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];

  UIView *iconView = [[UIView alloc] init];
  UIImage *iconBorderImage = [UIImage hyb_imageWithColor:[UIColor whiteColor] toSize:CGSizeMake(50, 100) cornerRadius:10 backgroundColor:[UIColor lightGrayColor] borderColor:[UIColor redColor] borderWidth:1];
  iconView.frame = CGRectMake(10, 210, 50, 100);
  iconView.layer.contents = (__bridge id _Nullable)(iconBorderImage.CGImage);
  [self.contentView addSubview:iconView];
  
  iconView = [[UIView alloc] init];
  iconBorderImage = [UIImage hyb_imageWithColor:[UIColor whiteColor] toSize:CGSizeMake(50, 100) cornerRadius:10 backgroundColor:[UIColor lightGrayColor] borderColor:[UIColor redColor] borderWidth:0];
  iconView.frame = CGRectMake(70, 210, 50, 100);
  iconView.layer.contents = (__bridge id _Nullable)(iconBorderImage.CGImage);
  [self.contentView addSubview:iconView];
  
  iconView = [[UIView alloc] init];
  iconBorderImage = [UIImage hyb_imageWithColor:[UIColor whiteColor] toSize:CGSizeMake(50, 100) cornerRadius:0 backgroundColor:[UIColor lightGrayColor] borderColor:[UIColor redColor] borderWidth:0];
  iconView.frame = CGRectMake(130, 210, 50, 100);
  iconView.layer.contents = (__bridge id _Nullable)(iconBorderImage.CGImage);
  [self.contentView addSubview:iconView];
  
  iconView = [[UIView alloc] init];
  iconBorderImage = [UIImage hyb_imageWithColor:[UIColor whiteColor] toSize:CGSizeMake(50, 100) cornerRadius:0 backgroundColor:[UIColor lightGrayColor] borderColor:[UIColor redColor] borderWidth:1];
  iconView.frame = CGRectMake(190, 210, 50, 100);
  iconView.layer.contents = (__bridge id _Nullable)(iconBorderImage.CGImage);
  [self.contentView addSubview:iconView];

  iconView = [[UIView alloc] init];
//  iconBorderImage =
  iconView.frame = CGRectMake(250, 210, 50, 100);
//  iconView.layer.contents = (__bridge id _Nullable)(iconBorderImage.CGImage);
  [self.contentView addSubview:iconView];
  iconView.hyb_borderWidth = 1;
  iconView.hyb_borderColor = [UIColor greenColor];
  iconView.backgroundColor = [UIColor whiteColor];
  [iconView hyb_addCornerRadius:10];
  
  // 为了性能更高，对图片做了缓存
  // 如果要修改背景颜色，需要再调用一次添加圆角，否则不会更新！
  iconView.backgroundColor = [UIColor redColor];
  [iconView hyb_addCornerRadius:10];
}


@end
