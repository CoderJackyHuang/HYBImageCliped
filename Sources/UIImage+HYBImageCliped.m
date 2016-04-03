//
//  UIImage+HYBCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UIImage+HYBmageCliped.h"

@implementation UIImage (HYBImageCliped)

- (UIImage *)hyb_clipToSize:(CGSize)targetSize {
  return [self hyb_clipToSize:targetSize isEqualScale:YES];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale {
  return [self hyb_private_clipImageToSize:targetSize
                              cornerRadius:0
                                   corners:UIRectCornerAllCorners
                           backgroundColor:[UIColor whiteColor]
                              isEqualScale:isEqualScale
                                  isCircle:NO];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale {
  return [self hyb_private_clipImageToSize:targetSize
                              cornerRadius:cornerRadius
                                   corners:UIRectCornerAllCorners
                           backgroundColor:backgroundColor
                              isEqualScale:isEqualScale
                                  isCircle:NO];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius {
  return [self hyb_clipToSize:targetSize
                 cornerRadius:cornerRadius
              backgroundColor:[UIColor whiteColor]
                 isEqualScale:YES];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale {
  return [self hyb_private_clipImageToSize:targetSize
                              cornerRadius:cornerRadius
                                   corners:corners
                           backgroundColor:backgroundColor
                              isEqualScale:isEqualScale
                                  isCircle:NO];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners {
  return [self hyb_clipToSize:targetSize
                 cornerRadius:cornerRadius
                      corners:corners
              backgroundColor:[UIColor whiteColor]
                 isEqualScale:YES];
}

- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale {
  return [self hyb_private_clipImageToSize:targetSize
                              cornerRadius:0
                                   corners:UIRectCornerAllCorners
                           backgroundColor:backgroundColor
                              isEqualScale:isEqualScale
                                  isCircle:YES];
}

- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize {
  return [self hyb_clipCircleToSize:targetSize backgroundColor:[UIColor whiteColor] isEqualScale:YES];
}

- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale
                   isCircle:(BOOL)isCircle {
  return [self hyb_private_clipImageToSize:targetSize
                              cornerRadius:cornerRadius
                                   corners:corners
                           backgroundColor:backgroundColor
                              isEqualScale:isEqualScale
                                  isCircle:isCircle];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius {
  return [self hyb_imageWithColor:color
                           toSize:targetSize
                     cornerRadius:cornerRadius
                  backgroundColor:[UIColor whiteColor]];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor {
  UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
  
  CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, targetRect);
  
  UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  if (cornerRadius != 0) {
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    if (backgroundColor) {
      [backgroundColor setFill];
      CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [finalImage drawInRect:targetRect];
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  
  return finalImage;
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize {
  return [self hyb_imageWithColor:color toSize:targetSize cornerRadius:0];
}

#pragma mark - Private
- (UIImage *)hyb_private_clipImageToSize:(CGSize)targetSize
                            cornerRadius:(CGFloat)cornerRadius
                                 corners:(UIRectCorner)corners
                         backgroundColor:(UIColor *)backgroundColor
                            isEqualScale:(BOOL)isEqualScale
                                isCircle:(BOOL)isCircle {
  if (targetSize.width <= 0 || targetSize.height <= 0) {
    return self;
  }
//  NSTimeInterval timerval = CFAbsoluteTimeGetCurrent();
 
  UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
  
  CGSize imgSize = self.size;
  
  CGSize resultSize = targetSize;
  if (isEqualScale) {
    CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
    resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
  }
  
  CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
  
  if (isCircle) {
    CGFloat width = MIN(resultSize.width, resultSize.height);
    targetRect = (CGRect){0, 0, width, width};
  }
  
  if (backgroundColor) {
    [backgroundColor setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
  }
  
  if (isCircle) {
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                cornerRadius:targetRect.size.width / 2].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
  } else if (cornerRadius > 0) {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
  }
  
  [self drawInRect:targetRect];
  
  UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
//  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
//        CFAbsoluteTimeGetCurrent() - timerval,
//        NSStringFromCGSize(imgSize),
//        NSStringFromCGSize(targetSize));
 
  return finalImage;
}

@end
