//
//  UIImageView+HYBImageCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBImageCliped.h"

@implementation UIImageView (HYBImageCliped)

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

- (UIImage *)hyb_setCircleImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
  return [self hyb_private_setImage:image
                               size:targetSize
                       cornerRadius:0
                        rectCorener:UIRectCornerAllCorners
                    backgroundColor:[UIColor whiteColor]
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
            backgroundColor:[UIColor whiteColor]
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
                    backgroundColor:[UIColor whiteColor]
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
            backgroundColor:[UIColor whiteColor]
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
    clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                       cornerRadius:cornerRadius
                                            corners:rectCorner
                                    backgroundColor:bgColor
                                       isEqualScale:isEqualScale
                                           isCircle:isCircle];
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
  });
  
  return willBeClipedImage;
}

@end
