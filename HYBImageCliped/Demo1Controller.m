//
//  Demo1Controller.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "Demo1Controller.h"
#import "Masonry.h"
#import "HYBImageCliped.h"

@implementation Demo1Controller

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor lightGrayColor];
  
  // 可以直接使用UIView来显示图片，不要求必须使用UIImageView
  UIView *cornerView1 = [[UIView alloc] init];
  cornerView1.frame = CGRectMake(10, 10, 80, 80);
  [self.view addSubview:cornerView1];
  
  cornerView1.backgroundColor = [UIColor redColor];
 UIImage *image = [UIImage imageNamed:@"bimg1.jpg"];
 [cornerView1 hyb_setCircleImage:image size:CGSizeMake(80, 80) isEqualScale:YES backgrounColor:[UIColor lightGrayColor] onCliped:^(UIImage *clipedImage) {
   
 }];
  
  // 当图片的宽高比，与控件的宽高比不相等时，裁剪图片圆角会显示不好或者不显示出来。这是因为压缩后
  // 的图片是等比例压缩的。如果不是等比例压缩，图片就会不清楚。
  UIImageView *cornerView2 = [[UIImageView alloc] init];
  cornerView2.frame = CGRectMake(100, 10, 80, 80);
  [self.view addSubview:cornerView2];
  cornerView2.backgroundColor = [UIColor redColor];
  [cornerView2 hyb_setImage:@"bimg5.jpg" cornerRadius:10 rectCorner:UIRectCornerTopLeft | UIRectCornerTopRight onCliped:^(UIImage *clipedImage) {
    // You can cache the cliped image when the control is use in cell that can be reused.
  }];
  
  // 当图片的宽高比，与控件的宽高比不相等时，裁剪图片圆角会显示不好或者不显示出来。这是因为压缩后
  // 的图片是等比例压缩的。如果不是等比例压缩，图片就会不清楚。
  UIImageView *cornerView3 = [[UIImageView alloc] init];
  cornerView3.frame = CGRectMake(200, 10, 80, 80);
  [self.view addSubview:cornerView3];
  cornerView3.backgroundColor = [UIColor redColor];
//  [cornerView3 hyb_setImage:@"bimg8.jpg" cornerRadius:10 rectCorner:UIRectCornerTopLeft];
  
  // 由于图片宽远大于高，因此若什么等比例压缩，会看不见大部分图片内容
  [cornerView3 hyb_setImage:@"bimg8.jpg" cornerRadius:10 rectCorner:UIRectCornerTopLeft |UIRectCornerBottomRight isEqualScale:NO onCliped:^(UIImage *clipedImage) {
    
  }];
  
  UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 80, 80)];
  view1.backgroundColor = [UIColor greenColor];
  [view1 hyb_addCorner:UIRectCornerTopLeft cornerRadius:10];
  [self.view addSubview:view1];
  
  UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
  view2.backgroundColor = [UIColor greenColor];
  [view2 hyb_addCorner:UIRectCornerTopRight cornerRadius:10];
  [self.view addSubview:view2];

  UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 80, 80)];
  view3.backgroundColor = [UIColor greenColor];
  [view3 hyb_addCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:10];
  [self.view addSubview:view3];


  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(10, 200, 80, 80);
  [self.view addSubview:imgView];
  
//   也可以直接使用UIView的扩展API哦。对于直接加载本地的图片，直接使用UIView的扩展API就只可以了。
  [imgView hyb_setCircleImage:@"img1.jpeg" size:CGSizeMake(80, 80) isEqualScale:YES backgrounColor:[UIColor lightGrayColor] onCliped:^(UIImage *clipedImage) {
    
  }];

  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(100, 200, 80, 80);
  // 先设置背景色，就可以生成与背景一样颜色的图片
  button.backgroundColor = [UIColor lightGrayColor];
  [self.view addSubview:button];
  [button hyb_setImage:@"img1.jpeg" forState:UIControlStateNormal cornerRadius:40 isEqualScale:YES];
  [button hyb_setImage:@"bimg5.jpg" forState:UIControlStateHighlighted cornerRadius:40 isEqualScale:NO];
  
  UIImageView *colorImageView = [[UIImageView alloc] init];
  colorImageView.frame = CGRectMake(200, 200, 80, 100);
  [self.view addSubview:colorImageView];
  colorImageView.image = [UIImage hyb_imageWithColor:[UIColor greenColor] toSize:CGSizeMake(80, 100) cornerRadius:20 backgroundColor:[UIColor lightGrayColor]];
  
  UIImageView *bimgView = [[UIImageView alloc] init];
  bimgView.frame = CGRectMake(10, 300, 80, 80);
  [self.view addSubview:bimgView];
  UIImage *bimg = [UIImage imageNamed:@"bimg4.jpg"];
  bimg.hyb_pathWidth = 3;
//  bimg.hyb_pathColor = [UIColor redColor];
  bimg.hyb_borderColor = [UIColor redColor];
  bimg.hyb_borderWidth = 0.5;
  bimgView.image = [bimg hyb_clipToSize:bimgView.bounds.size cornerRadius:0 corners:UIRectCornerAllCorners backgroundColor:[UIColor lightGrayColor] isEqualScale:NO isCircle:YES];
  
  UIImageView *bimgView1 = [[UIImageView alloc] init];
  bimgView1.frame = CGRectMake(100, 300, 80, 80);
  [self.view addSubview:bimgView1];
  UIImage *bimg1 = [UIImage imageNamed:@"bimg4.jpg"];

  bimg1.hyb_pathWidth = 3;
  bimg1.hyb_pathColor = [UIColor redColor];
  bimgView1.image = [bimg1 hyb_clipToSize:bimgView1.bounds.size cornerRadius:0 corners:UIRectCornerAllCorners backgroundColor:[UIColor lightGrayColor] isEqualScale:NO isCircle:NO];
  
  UIImageView *bimgView3 = [[UIImageView alloc] init];
  bimgView3.frame = CGRectMake(200, 300, 80, 80);
  [self.view addSubview:bimgView3];
  UIImage *bimg3 = [UIImage imageNamed:@"bimg4.jpg"];
  bimg3.hyb_pathWidth = 5;
    bimg.hyb_pathColor = [UIColor yellowColor];
//  bimg3.hyb_borderColor = [UIColor redColor];
  bimg3.hyb_borderWidth = 1;
  bimgView3.image = [bimg hyb_clipCircleToSize:CGSizeMake(80, 80) backgroundColor:[UIColor lightGrayColor] isEqualScale:YES];
  
}

@end
