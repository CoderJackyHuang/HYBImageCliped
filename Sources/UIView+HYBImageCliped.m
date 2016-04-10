//
//  UIView+HYBImageCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <objc/runtime.h>
#import "HYBImageCliped.h"

@interface _HYBCornerImage : NSObject

@property (nonatomic, strong) UIImage *leftUpImage;
@property (nonatomic, strong) UIImage *leftDownImage;
@property (nonatomic, strong) UIImage *rightUpImage;
@property (nonatomic, strong) UIImage *rightDownImage;

@end

@implementation _HYBCornerImage

@end

@interface _HYBCornerImageView : UIImageView

@end

@implementation _HYBCornerImageView

@end

@interface _HYBCornerBorderLayer : CAShapeLayer

@end

@implementation _HYBCornerBorderLayer

@end

@interface HYBImageClipedManager (CorenrImages)


@end

@implementation HYBImageClipedManager (CorenrImages)

- (NSCache *)hyb_sharedCornerImages {
  return [HYBImageClipedManager shared].sharedCache;
}

- (NSString *)hyb_hashKeyWithColor:(UIColor *)color radius:(CGFloat)radius border:(CGFloat)border borderColor:(UIColor *)borderColor {
  const CGFloat *colors = CGColorGetComponents(color.CGColor);
  NSUInteger count = CGColorGetNumberOfComponents(color.CGColor);
  
  NSMutableString *hashStr = [NSMutableString string];
  
  for (NSUInteger index = 0; index < count; index ++) {
    [hashStr appendString:[NSString stringWithFormat:@"%@", @(colors[index])]];
  }
  
  if (borderColor) {
    const CGFloat *colors = CGColorGetComponents(borderColor.CGColor);
    NSUInteger count = CGColorGetNumberOfComponents(borderColor.CGColor);
    
    for (NSUInteger index = 0; index < count; index ++) {
      [hashStr appendString:[NSString stringWithFormat:@"%@", @(colors[index])]];
    }
  }
  
  [hashStr appendString:[NSString stringWithFormat:@"%@", @(radius)]];
  [hashStr appendString:[NSString stringWithFormat:@"%@", @(border)]];
  
  return [NSString stringWithFormat:@"%@", @([hashStr hash])];
}


- (NSString *)hyb_hashKeyWithColor:(UIColor *)color radius:(CGFloat)radius border:(CGFloat)border {
  return [self hyb_hashKeyWithColor:color radius:radius border:border borderColor:nil];
}

- (_HYBCornerImage *)hyb_cornerImageWithColor:(UIColor *)color radius:(CGFloat)radius border:(CGFloat)border {
  NSString *key = [[HYBImageClipedManager shared] hyb_hashKeyWithColor:color radius:radius border:border];
  
  _HYBCornerImage *image = [[[HYBImageClipedManager shared] hyb_sharedCornerImages] objectForKey:key];
  
  if (image == nil) {
    UIImage *cornerImage = nil;

    radius *= [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL,
                                                    radius,
                                                    radius,
                                                    8,
                                                    4 * radius,
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
    
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextMoveToPoint(contextRef, radius, 0);
    CGContextAddLineToPoint(contextRef, 0, 0);
    CGContextAddLineToPoint(contextRef, 0, radius);
    CGContextAddArc(contextRef,
                    radius,
                    radius,
                    radius,
                    180 * (M_PI / 180.0f),
                    270 * (M_PI / 180.0f),
                    0);
    
    CGContextFillPath(contextRef);
    
    CGImageRef imageCG = CGBitmapContextCreateImage(contextRef);
    cornerImage = [UIImage imageWithCGImage:imageCG];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageCG);
    
    CGImageRef imageRef = cornerImage.CGImage;
    
    UIImage *leftUpImage = [[UIImage alloc] initWithCGImage:imageRef
                                                      scale:[UIScreen mainScreen].scale
                                                orientation:UIImageOrientationRight];
    UIImage *rightUpImage = [[UIImage alloc] initWithCGImage:imageRef
                                                       scale:[UIScreen mainScreen].scale
                                                 orientation:UIImageOrientationLeftMirrored];
    UIImage *rightDownImage = [[UIImage alloc] initWithCGImage:imageRef
                                                         scale:[UIScreen mainScreen].scale
                                                   orientation:UIImageOrientationLeft];
   UIImage *leftDownImage = [[UIImage alloc] initWithCGImage:imageRef
                                               scale:[UIScreen mainScreen].scale
                                         orientation:UIImageOrientationUp];

    image = [[_HYBCornerImage alloc] init];
    image.leftDownImage = leftDownImage;
    image.leftUpImage = leftUpImage;
    image.rightUpImage = rightUpImage;
    image.rightDownImage = rightDownImage;
    
    [[[HYBImageClipedManager shared] hyb_sharedCornerImages] setObject:image forKey:key];
  }
  
  return image;
}

@end

static const char *s_hyb_image_borderColorKey = "s_hyb_image_borderColorKey";
static const char *s_hyb_image_borderWidthKey = "s_hyb_image_borderWidthKey";
static const char *s_hyb_image_pathColorKey = "s_hyb_image_pathColorKey";
static const char *s_hyb_image_pathWidthKey = "s_hyb_image_pathWidthKey";

@implementation UIView (HYBImageCliped)

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

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
  [self hyb_addCorner:corner cornerRadius:cornerRadius size:targetSize backgroundColor:nil];
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize backgroundColor:(UIColor *)backgroundColor {
  if (corner == UIRectCornerAllCorners) {
    // 缓存起来，这样性能提升很多
    if (self.hyb_borderWidth > 0 || cornerRadius > 0) {
      NSString *lastKey = [self hyb_lastBorderImageKey];
      NSString *key = [[HYBImageClipedManager shared] hyb_hashKeyWithColor:self.backgroundColor radius:cornerRadius border:self.hyb_borderWidth borderColor:self.hyb_borderColor];
      
      if (lastKey == nil || ![lastKey isEqualToString:key]) {
        UIColor *bgColor = [self _private_color:backgroundColor];
        UIImage *image = [UIImage hyb_imageWithColor:self.backgroundColor toSize:targetSize cornerRadius:cornerRadius backgroundColor:bgColor borderColor:self.hyb_borderColor borderWidth:self.hyb_borderWidth];
        self.backgroundColor = [UIColor colorWithPatternImage:image];
        [self setHyb_lastBorderImageKey:key];
      }
    }
  } else {
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if ([obj isKindOfClass:[_HYBCornerBorderLayer class]]) {
        return;
      }
    }];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    _HYBCornerBorderLayer *borderLayer = [_HYBCornerBorderLayer layer];
    borderLayer.path = path.CGPath;
    borderLayer.lineWidth = self.hyb_borderWidth;
    borderLayer.strokeColor = self.hyb_borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
    
    UIColor *bgColor = [self _private_color:backgroundColor];
    [self _hyb_addCornerImages:corner
                        radius:cornerRadius
                          size:targetSize
                         color:bgColor];
  }
}

- (UIColor *)_private_color:(UIColor *)backgroundColor {
  UIColor *bgColor = nil;
  if (backgroundColor == nil || CGColorEqualToColor(backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
    UIView *superview = self.superview;
    while (superview.backgroundColor == nil || CGColorEqualToColor(superview.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
      if (!superview) {
        break;
      }
      
      superview = [superview superview];
    }
    
    bgColor = superview.backgroundColor;
  } else {
    bgColor = backgroundColor;
  }
  
  if (bgColor == nil) {
    bgColor = self.backgroundColor;
  }
  
  if (CGColorEqualToColor(bgColor.CGColor, [UIColor clearColor].CGColor)) {
    bgColor = [UIColor whiteColor];
  }
  
  return bgColor;
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
  [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius size:self.bounds.size backgroundColor:backgroundColor];
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
  [self hyb_addCorner:corner cornerRadius:cornerRadius size:self.bounds.size];
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
  [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius size:targetSize];
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius {
  [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}

- (UIImage *)hyb_setImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:targetSize
                       cornerRadius:0
                        rectCorener:UIRectCornerAllCorners
                    backgroundColor:nil
                       isEqualScale:isEqualScale
                           isCircle:NO
                           onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image size:self.frame.size isEqualScale:isEqualScale onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                 backgrounColor:(UIColor *)backgroundColor
                       onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:targetSize
                       cornerRadius:0
                        rectCorener:UIRectCornerAllCorners
                    backgroundColor:backgroundColor
                       isEqualScale:isEqualScale
                           isCircle:YES
                           onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:targetSize
                       cornerRadius:0
                        rectCorener:UIRectCornerAllCorners
                    backgroundColor:nil
                       isEqualScale:isEqualScale
                           isCircle:YES
                           onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
  return [self hyb_setCircleImage:image size:self.frame.size isEqualScale:isEqualScale onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image
                       size:targetSize
               cornerRadius:cornerRaidus
                 rectCorner:UIRectCornerAllCorners
            backgroundColor:backgroundColor
               isEqualScale:isEqualScale
                   onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image
                       size:targetSize
               cornerRadius:cornerRaidus
            backgroundColor:nil
               isEqualScale:YES
                   onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image size:self.frame.size cornerRadius:cornerRaidus onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:targetSize
                       cornerRadius:cornerRaidus
                        rectCorener:rectCorner
                    backgroundColor:backgroundColor
                       isEqualScale:isEqualScale
                           isCircle:NO
                           onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:self.frame.size
                       cornerRadius:cornerRaidus
                        rectCorener:rectCorner
                    backgroundColor:nil
                       isEqualScale:isEqualScale
                           isCircle:NO
                           onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image
                       size:targetSize
               cornerRadius:cornerRaidus
                 rectCorner:rectCorner
            backgroundColor:nil
               isEqualScale:YES
                   onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback {
  return [self hyb_setImage:image
                       size:self.frame.size
               cornerRadius:cornerRaidus
                 rectCorner:rectCorner
                   onCliped:callback];
}

#pragma makr - Private
- (UIImage *)hyb_private_setImage:(id)image
                             size:(CGSize)targetSize
                     cornerRadius:(CGFloat)cornerRadius
                      rectCorener:(UIRectCorner)rectCorner
                  backgroundColor:(UIColor *)bgColor
                     isEqualScale:(BOOL)isEqualScale
                         isCircle:(BOOL)isCircle
                         onCliped:(HYBClipedCallback)callback {
  if (image == nil) {
    return nil;
  }
  
  if (bgColor == nil || CGColorEqualToColor(bgColor.CGColor, [UIColor clearColor].CGColor)) {
    UIView *superview = self.superview;
    while (superview.backgroundColor == nil || CGColorEqualToColor(superview.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
      if (!superview) {
        break;
      }
      
      superview = [superview superview];
    }
    
    bgColor = superview.backgroundColor;
  }
  
  if (CGColorEqualToColor(bgColor.CGColor, [UIColor clearColor].CGColor)) {
    bgColor = [UIColor whiteColor];
  }
  
  UIImage *willBeClipedImage = image;
  if ([image isKindOfClass:[NSString class]]) {
    willBeClipedImage = [UIImage imageNamed:image];
  } else if ([image isKindOfClass:[UIImage class]]) {
    willBeClipedImage = image;
  } else if ([image isKindOfClass:[NSData class]]) {
    willBeClipedImage = [UIImage imageWithData:image];
  }
  
  if (willBeClipedImage == nil) {
    return nil;
  }
  
  __block UIImage *clipedImage = nil;
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    willBeClipedImage.hyb_pathColor = self.hyb_pathColor;
    willBeClipedImage.hyb_pathWidth = self.hyb_pathWidth;
    willBeClipedImage.hyb_borderColor = self.hyb_borderColor;
    willBeClipedImage.hyb_borderWidth = self.hyb_borderWidth;
    
    @autoreleasepool {
      if (willBeClipedImage.hyb_borderWidth > 0 || willBeClipedImage.hyb_pathWidth > 0) {
        if (![self hyb_hasAddEmpty]) {
          clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                             cornerRadius:cornerRadius
                                                  corners:rectCorner
                                          backgroundColor:bgColor
                                             isEqualScale:isEqualScale
                                                 isCircle:isCircle];
        } else {
          clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                             cornerRadius:0
                                                  corners:rectCorner
                                          backgroundColor:nil
                                             isEqualScale:isEqualScale
                                                 isCircle:isCircle];
          [self _hyb_addCornerImages:rectCorner radius:cornerRadius size:targetSize color:bgColor];
        }
      } else if ((willBeClipedImage.size.width / targetSize.width > 1.5
                  || willBeClipedImage.size.height / targetSize.height > 1.5)) {
        clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                           cornerRadius:0
                                                corners:rectCorner
                                        backgroundColor:nil
                                           isEqualScale:isEqualScale
                                               isCircle:isCircle];
        [self _hyb_addCornerImages:rectCorner radius:cornerRadius size:targetSize color:bgColor];
      } else {
        clipedImage = willBeClipedImage;
        [self _hyb_addCornerImages:rectCorner radius:cornerRadius size:targetSize color:bgColor];
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        if (clipedImage) {
          if ([self isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)self;
            imgView.image = clipedImage;
          } else if ([self isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)self;
            [button setImage:clipedImage forState:UIControlStateNormal];
          } else {
            self.layer.contents = (__bridge id _Nullable)(clipedImage.CGImage);
          }
          
          if (callback) {
            callback(clipedImage);
          }
        }
      });
    }
  });
  
  return willBeClipedImage;
}

- (void)_hyb_addCornerImages:(UIRectCorner)corners radius:(CGFloat)radius size:(CGSize)targetSize color:(UIColor *)color {
  if ([self hyb_hasAddEmpty]) {
    return;
  }
  
  CGFloat value1 = targetSize.width - radius / 2.0;
  CGFloat value2 = radius / 2.0;
  CGFloat value3 = targetSize.height - radius / 2.0;
  
  BOOL shouldAdd = NO;
  _HYBCornerImage *image = [[HYBImageClipedManager shared] hyb_cornerImageWithColor:color
                                                                             radius:radius
                                                                             border:self.hyb_borderWidth];
  
  if (corners & UIRectCornerTopLeft && image.leftUpImage) {
    _HYBCornerImageView *leftUpImageView = [[_HYBCornerImageView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    [leftUpImageView setImage:image.leftUpImage];
    leftUpImageView.center = CGPointMake(value2, value2);
    [self addSubview:leftUpImageView];
    shouldAdd = YES;
  }
  
  if (corners & UIRectCornerTopRight && image.rightUpImage) {
    _HYBCornerImageView *rightUpImageView = [[_HYBCornerImageView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    [rightUpImageView setImage:image.rightUpImage];
    rightUpImageView.center = CGPointMake(value1, value2);
    [self addSubview:rightUpImageView];
    shouldAdd = YES;
  }
  
  if (corners & UIRectCornerBottomRight && image.rightDownImage) {
    _HYBCornerImageView *rightDownImageView = [[_HYBCornerImageView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    [rightDownImageView setImage:image.rightDownImage];
    rightDownImageView.center = CGPointMake(value1, value3);
    [self addSubview:rightDownImageView];
    shouldAdd = YES;
  }
  
  if (corners & UIRectCornerBottomLeft && image.leftDownImage) {
    _HYBCornerImageView *leftDownImageView = [[_HYBCornerImageView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    [leftDownImageView setImage:image.leftDownImage];
    leftDownImageView.center = CGPointMake(value2, value3);
    [self addSubview:leftDownImageView];
    shouldAdd = YES;
  }
  
  objc_setAssociatedObject(self, "hyb_hasAddEmpty", @(shouldAdd), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hyb_hasAddEmpty {
  NSNumber *hasAdd = objc_getAssociatedObject(self, "hyb_hasAddEmpty");
  if (hasAdd && [hasAdd respondsToSelector:@selector(boolValue)]) {
    return [hasAdd boolValue];
  }
  
  return NO;
}

- (NSString *)hyb_lastBorderImageKey {
  return objc_getAssociatedObject(self, "hyb_lastBorderImageKey");
}

- (void)setHyb_lastBorderImageKey:(NSString *)key {
  objc_setAssociatedObject(self,
                           "hyb_lastBorderImageKey",
                           key,
                           OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
