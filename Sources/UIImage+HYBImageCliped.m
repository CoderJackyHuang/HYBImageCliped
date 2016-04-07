//
//  UIImage+HYBCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UIImage+HYBmageCliped.h"
#import <objc/runtime.h>

static const char *s_hyb_image_borderColorKey = "s_hyb_image_borderColorKey";
static const char *s_hyb_image_borderWidthKey = "s_hyb_image_borderWidthKey";
static const char *s_hyb_image_pathColorKey = "s_hyb_image_pathColorKey";
static const char *s_hyb_image_pathWidthKey = "s_hyb_image_pathWidthKey";

@implementation UIImage (HYBImageCliped)

#pragma mark - Border
- (CGFloat)hyb_borderWidth {
  NSNumber *borderWidth = objc_getAssociatedObject(self, s_hyb_image_borderWidthKey);
  
  if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
    return borderWidth.doubleValue;
  }
  
  return 1;
}

- (void)setHyb_borderWidth:(CGFloat)hyb_borderWidth {
  objc_setAssociatedObject(self,
                           s_hyb_image_borderWidthKey,
                           @(hyb_borderWidth),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hyb_pathWidth {
  NSNumber *width = objc_getAssociatedObject(self, s_hyb_image_pathWidthKey);
  
  if ([width respondsToSelector:@selector(doubleValue)]) {
    return width.doubleValue;
  }
  
  return 0;
}

- (void)setHyb_pathWidth:(CGFloat)hyb_pathWidth {
  objc_setAssociatedObject(self,
                           s_hyb_image_pathWidthKey,
                           @(hyb_pathWidth),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hyb_pathColor {
  UIColor *color = objc_getAssociatedObject(self, s_hyb_image_pathColorKey);
  
  if (color) {
    return color;
  }
  
  return [UIColor whiteColor];
}

- (void)setHyb_pathColor:(UIColor *)hyb_pathColor {
  objc_setAssociatedObject(self,
                           s_hyb_image_pathColorKey,
                           hyb_pathColor,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}

- (UIColor *)hyb_borderColor {
  UIColor *color = objc_getAssociatedObject(self, s_hyb_image_borderColorKey);
  
  if (color) {
    return color;
  }
  
  return [UIColor lightGrayColor];
}

- (void)setHyb_borderColor:(UIColor *)hyb_borderColor {
  objc_setAssociatedObject(self,
                           s_hyb_image_borderColorKey,
                           hyb_borderColor,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Clip
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
/*
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
  
  UIGraphicsBeginImageContextWithOptions(targetRect.size, YES, [UIScreen mainScreen].scale);
  
  if (backgroundColor) {
    [backgroundColor setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
  }
  
  
  CGFloat pathWidth = self.hyb_pathWidth;
  CGFloat borderWidth = self.hyb_borderWidth;
  
  if (pathWidth > 0 && borderWidth > 0 && (isCircle || cornerRadius == 0)) {
    UIColor *borderColor = self.hyb_borderColor;
    UIColor *pathColor = self.hyb_pathColor;
    
    CGRect rect = targetRect;
    CGRect rectImage = rect;
    rectImage.origin.x += pathWidth;
    rectImage.origin.y += pathWidth;
    rectImage.size.width -= pathWidth * 2.0;
    rectImage.size.height -= pathWidth * 2.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (isCircle) {
      CGContextAddEllipseInRect(ctx, rect);
    } else {
      CGContextAddRect(ctx, rect);
    }
    
    CGContextClip(ctx);
    [self drawInRect:rectImage];
    
    // 添加内线和外线
    rectImage.origin.x -= borderWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0;
    rectImage.size.width += borderWidth;
    rectImage.size.height += borderWidth;
    
    rect.origin.x += borderWidth / 2.0;
    rect.origin.y += borderWidth / 2.0;
    rect.size.width -= borderWidth;
    rect.size.height -= borderWidth;
    
    CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
    CGContextSetLineWidth(ctx, borderWidth);
    
    if (isCircle) {
      CGContextStrokeEllipseInRect(ctx, rectImage);
      CGContextStrokeEllipseInRect(ctx, rect);
    } else if (cornerRadius == 0) {
      CGContextStrokeRect(ctx, rectImage);
      CGContextStrokeRect(ctx, rect);
    }
    
    float centerPathWidth = pathWidth - borderWidth * 2.0;
    CGContextSetLineWidth(ctx, centerPathWidth);
    CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
    
    rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.size.width += borderWidth + centerPathWidth;
    rectImage.size.height += borderWidth + centerPathWidth;
    
    if (isCircle) {
      CGContextStrokeEllipseInRect(ctx, rectImage);
    } else if (cornerRadius == 0) {
      CGContextStrokeRect(ctx, rectImage);
    }
  } else {
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
  }
  
  UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  //  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
  //        CFAbsoluteTimeGetCurrent() - timerval,
  //        NSStringFromCGSize(imgSize),
  //        NSStringFromCGSize(targetSize));
  
  return finalImage;
}
*/

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
  
  UIGraphicsBeginImageContextWithOptions(targetRect.size, YES, [UIScreen mainScreen].scale);
  
  if (backgroundColor) {
    [backgroundColor setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
  }
  
  CGFloat pathWidth = self.hyb_pathWidth;
  CGFloat borderWidth = self.hyb_borderWidth;
  
  if (pathWidth > 0 && borderWidth > 0 && (isCircle || cornerRadius == 0)) {
    UIColor *borderColor = self.hyb_borderColor;
    UIColor *pathColor = self.hyb_pathColor;
    
    CGRect rect = targetRect;
    CGRect rectImage = rect;
    rectImage.origin.x += pathWidth;
    rectImage.origin.y += pathWidth;
    rectImage.size.width -= pathWidth * 2.0;
    rectImage.size.height -= pathWidth * 2.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (isCircle) {
      CGContextAddEllipseInRect(ctx, rect);
    } else {
      CGContextAddRect(ctx, rect);
    }
    
    CGContextClip(ctx);
    [self drawInRect:rectImage];
    
    // 添加内线和外线
    rectImage.origin.x -= borderWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0;
    rectImage.size.width += borderWidth;
    rectImage.size.height += borderWidth;
    
    rect.origin.x += borderWidth / 2.0;
    rect.origin.y += borderWidth / 2.0;
    rect.size.width -= borderWidth;
    rect.size.height -= borderWidth;
    
    CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
    CGContextSetLineWidth(ctx, borderWidth);
    
    if (isCircle) {
      CGContextStrokeEllipseInRect(ctx, rectImage);
      CGContextStrokeEllipseInRect(ctx, rect);
    } else if (cornerRadius == 0) {
      CGContextStrokeRect(ctx, rectImage);
      CGContextStrokeRect(ctx, rect);
    }
    
    float centerPathWidth = pathWidth - borderWidth * 2.0;
    CGContextSetLineWidth(ctx, centerPathWidth);
    CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
    
    rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.size.width += borderWidth + centerPathWidth;
    rectImage.size.height += borderWidth + centerPathWidth;
    
    if (isCircle) {
      CGContextStrokeEllipseInRect(ctx, rectImage);
    } else if (cornerRadius == 0) {
      CGContextStrokeRect(ctx, rectImage);
    }
  } else if (pathWidth > 0 && borderWidth > 0 && cornerRadius > 0 && !isCircle) {
    UIColor *borderColor = self.hyb_borderColor;
    UIColor *pathColor = self.hyb_pathColor;
    
    CGRect rect = targetRect;
    CGRect rectImage = rect;
    rectImage.origin.x += pathWidth;
    rectImage.origin.y += pathWidth;
    rectImage.size.width -= pathWidth * 2.0;
    rectImage.size.height -= pathWidth * 2.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawInRect:rectImage];
    
    // 添加内线和外线
    rectImage.origin.x -= borderWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0;
    rectImage.size.width += borderWidth;
    rectImage.size.height += borderWidth;
    
    rect.origin.x += borderWidth / 2.0;
    rect.origin.y += borderWidth / 2.0;
    rect.size.width -= borderWidth;
    rect.size.height -= borderWidth;
    
    CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
    CGContextSetLineWidth(ctx, borderWidth);
    
    CGFloat minusPath1 = pathWidth / 2;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius - minusPath1, cornerRadius - minusPath1)];
    CGContextAddPath(ctx, path1.CGPath);
    
    CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
    CGContextSetLineWidth(ctx, borderWidth);
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect
                                                byRoundingCorners:corners
                                                      cornerRadii:CGSizeMake(cornerRadius + minusPath1 ,cornerRadius + minusPath1)];
    CGContextAddPath(ctx, path2.CGPath);
    CGContextStrokePath(ctx);
    
    float centerPathWidth = pathWidth - borderWidth * 2.0;
    CGContextSetLineWidth(ctx, centerPathWidth);
    CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
    
    rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
    rectImage.size.width += borderWidth + centerPathWidth;
    rectImage.size.height += borderWidth + centerPathWidth;
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                                byRoundingCorners:corners
                                                      cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(ctx, path3.CGPath);
    CGContextStrokePath(ctx);
  } else {
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
  }
  
  UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  //  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
  //        CFAbsoluteTimeGetCurrent() - timerval,
  //        NSStringFromCGSize(imgSize),
  //        NSStringFromCGSize(targetSize));
  
  return finalImage;
}

@end
