//
//  UIView+HYBImageCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UIView+HYBImageCliped.h"

@implementation UIView (HYBImageCliped)

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:corner
                                                   cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
  CAShapeLayer *layer = [CAShapeLayer layer];
  layer.frame = self.bounds;
  layer.path = path.CGPath;
  
  self.layer.mask = layer;
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius {
  [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}

@end
