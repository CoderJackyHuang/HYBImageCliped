//
//  Demo1Controller.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "Demo1Controller.h"
#import "Masonry.h"
//#import "UIImageView+WebCache.h"
#import "HYBImageCliped.h"

@implementation Demo1Controller

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *cornerView1 = [[UIImageView alloc] init];
  cornerView1.frame = CGRectMake(10, 10, 80, 80);
  [self.view addSubview:cornerView1];
  
  cornerView1.backgroundColor = [UIColor redColor];
 UIImage *image = [UIImage imageNamed:@"bimg1.jpg"];
  [cornerView1 hyb_setCircleImage:image isEqualScale:YES onCliped:^(UIImage *clipedImage) {
    NSLog(@"clipedImageSize: %@", NSStringFromCGSize(clipedImage.size));
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
  [imgView hyb_setCircleImage:@"img1.jpeg" isEqualScale:YES onCliped:^(UIImage *clipedImage) {
    
  }];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(100, 200, 80, 80);
  button.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:button];
  [button hyb_setImage:@"img1.jpeg" forState:UIControlStateNormal cornerRadius:40 isEqualScale:YES];
  [button hyb_setImage:@"bimg5.jpg" forState:UIControlStateHighlighted cornerRadius:40 isEqualScale:NO];
  
  UIImageView *colorImageView = [[UIImageView alloc] init];
  colorImageView.frame = CGRectMake(200, 200, 80, 100);
  [self.view addSubview:colorImageView];
  colorImageView.image = [UIImage hyb_imageWithColor:[UIColor greenColor] toSize:CGSizeMake(80, 100) cornerRadius:20];
}

@end
