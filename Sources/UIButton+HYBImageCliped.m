//
//  UIButton+HYBImageCliped.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBImageCliped.h"

@implementation UIButton (HYBImageCliped)

- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale {
  [self hyb_setImage:image
            forState:state
              toSize:self.frame.size
        cornerRadius:cornerRadius
        isEqualScale:isEqualScale];
}

- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
              toSize:(CGSize)targetSize
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale {
  [self _private_hyb_setImage:image
                     forState:state
            isBackgroundImage:NO
                       toSize:targetSize
                 cornerRadius:cornerRadius
                 isEqualScale:isEqualScale];
}

- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale {
  [self hyb_setBackgroundImage:image
                      forState:state
                        toSize:self.frame.size
                  cornerRadius:cornerRadius
                  isEqualScale:isEqualScale];
}

- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale {
  [self _private_hyb_setImage:image
                     forState:state
            isBackgroundImage:YES
                       toSize:targetSize
                 cornerRadius:cornerRadius
                 isEqualScale:isEqualScale];
}

#pragma mark - Private
- (void)_private_hyb_setImage:(id)image
                     forState:(UIControlState)state
            isBackgroundImage:(BOOL)isBackImage
                       toSize:(CGSize)targetSize
                 cornerRadius:(CGFloat)cornerRadius
                 isEqualScale:(BOOL)isEqualScale {
  if (image == nil || targetSize.width == 0 || targetSize.height == 0) {
    return;
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
    return;
  }
  
  __block UIImage *clipedImage = nil;
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    @autoreleasepool {
      clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                         cornerRadius:cornerRadius
                                              corners:UIRectCornerAllCorners
                                      backgroundColor:self.backgroundColor
                                         isEqualScale:isEqualScale
                                             isCircle:NO];
      dispatch_async(dispatch_get_main_queue(), ^{
        if (clipedImage) {
          if (isBackImage) {
            [self setBackgroundImage:clipedImage forState:state];
          } else {
            [self setImage:clipedImage forState:state];
          }
        }
      });
    }
  });
}

@end
