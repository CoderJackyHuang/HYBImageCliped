//
//  HYBImageClipedManager.h
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *	此类用于处理图片缓存
 */
@interface HYBImageClipedManager : NSObject

/**
 *	根据存储时指定的key从本地获取已剪裁好的图片。同步操作
 *
 *	@param key	通常是URL。在内部会进行MD5
 *
 *	@return 从本地读取图片，不会存储到内存中，用于解决图片列表中内存暴涨问题
 */
+ (UIImage *)clipedImageFromDiskWithKey:(NSString *)key;

/**
 *	在裁剪成功后，可以调用此API，将剪裁后的图片存储到本地。同步操作。
 *
 *	@param clipedImage	已剪裁好的图片
 *	@param key					唯一key，通常是指URL。内部会进行MD5.
 */
+ (void)storeClipedImage:(UIImage *)clipedImage toDiskWithKey:(NSString *)key;

/**
 *	获取本地已存储的所有已剪裁的缓存大小，单位为bytes
 *
 *	@return 缓存大小
 */
+ (unsigned long long)imagesCacheSize;

/**
 *	清除缓存
 */
+ (void)clearClipedImagesCache;

@end
