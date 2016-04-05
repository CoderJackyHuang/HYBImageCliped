//
//  UIButton+HYBImageCliped.h
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
 * 下面是一个小例子，设置正常和高亮状态下的图片:
 *
 * [button hyb_setImage:@"img1.jpeg" forState:UIControlStateNormal cornerRadius:40 isEqualScale:YES];
   [button hyb_setImage:@"bimg5.jpg" forState:UIControlStateHighlighted cornerRadius:40 isEqualScale:NO];
 */
@interface UIButton (HYBImageCliped)

#pragma mark - 设置按钮图片
/**
 *	处理图片过大问题，要求button本身的size已经确定有值，否则不处理.
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image				图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *	@param cornerRadius	圆角
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
              cornerRadius:(CGFloat)cornerRadius
              isEqualScale:(BOOL)isEqualScale;

/**
 *	处理图片过大问题，要求button本身的size已经确定有值，否则不处理
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可*
 *
 *	@param image				图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *  @param targetSize   图片最终大小
 *	@param cornerRadius	圆角
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
              toSize:(CGSize)targetSize
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale;

#pragma mark - 设置按钮背景图片
/**
 *	处理图片大小与控件大小不一致问题。设置背景图片。要求按钮本身已经有确定的大小。
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image        图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *	@param cornerRadius	圆角大小
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;

/**
 *	处理图片大小与控件大小不一致问题。设置背景图片。要求按钮本身已经有确定的大小。
 *  若要设置生成图片的背景颜色，直接设置self.backgroundColor即可
 *
 *	@param image        图片名称或图片对象，也只可以是图片的NSData。
 *	@param state				状态
 *  @param targetSize   图片最终大小
 *	@param cornerRadius	圆角大小
 *	@param isEqualScale	是否是等比例压缩
 */
- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;

@end
