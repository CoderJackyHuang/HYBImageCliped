//
//  UIView+HYBImageCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UIView+HYBImageCliped.h"

@implementation UIView (HYBImageCliped)

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
  CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                             byRoundingCorners:corner
                                                   cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
  CAShapeLayer *layer = [CAShapeLayer layer];
  layer.frame = frame;
  layer.path = path.CGPath;
  
  self.layer.mask = layer;
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
  [self hyb_addCorner:corner cornerRadius:cornerRadius size:self.bounds.size];
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius {
  [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}

@end
