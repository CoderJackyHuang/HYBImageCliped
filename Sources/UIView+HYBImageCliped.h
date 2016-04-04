//
//  UIView+HYBImageCliped.h
//  HYBImageCliped
//
//  Created by huangyibiao on 16/3/31.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * GITHUB           : https://github.com/CoderJackyHuang/HYBImageCliped
 * Chinese Document : http://www.henishuo.com/hybimagecliped-image-cornerradius/
 * Author Blog      : http://www.henishuo.com/
 * Email            : huangyibiao520@163.com
 *
 * Please give me a feed back when there is something wrong, or you need a special effec.
 */


/**
 *  扩展控件通过mask来实现添加任意圆角
 */
@interface UIView (HYBImageCliped)

#pragma mark - 给任意UIView添加圆角（非图片）
/**
 *	给控件本身添加圆角，不是通过图片实现的。要求控件本身的frame是确定的，非自动布局才行。
 *
 *	@param corner			  多个圆角可通过UIRectCornerTopLeft | UIRectCornerTopRight这样来使用
 *	@param cornerRadius	圆角大小
 *
 *  @Example             
 *  [cornerView3 hyb_setImage:@"bimg8.jpg" cornerRadius:10 rectCorner:UIRectCornerTopLeft |UIRectCornerBottomRight isEqualScale:NO onCliped:^(UIImage *clipedImage) {
      // 如果需要复用，可在异步剪裁后，得到已剪裁后的图片，可另行他用
   }];
 */
- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

/**
 * corner为UIRectCornerAllCorners，bounds大小已经有才能使用
 *
 * @Example   
 * 添加一个圆角：[view1 hyb_addCorner:UIRectCornerTopLeft cornerRadius:10];
 */
- (void)hyb_addCornerRadius:(CGFloat)cornerRadius;

/**
 *  给控件本身添加圆角，不是通过图片实现的。
 *
 *	@param corner       添加哪些圆角
 *	@param cornerRadius	圆角大小
 *	@param targetSize		目标大小，即控件的frame.size
 */
- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

@end
