# HYBImageCliped
开源高效处理圆角的扩展，包括UIImageView、UIView、UIButton、UIImage的扩展API，可根据图片颜色生成图片带任意圆角，可给UIButton根据不同状态处理图片。所有生成图片都不会引起离屏渲染且不会引起blended color layer、misaligned image等。

#概述

**开源项目名称**：HYBImageCliped  
**当前版本：**2.1.0  
**项目用途：**可给任意继承UIView的控件添加任意多个圆角、可根据颜色生成图片且可带任意个圆角、给UIButton设置不同状态下的图片且可带任意圆角、给UIImageView设置任意图片，支持带圆角或者直接生成圆形。上述功能都不会造成离屏渲染。

#版本变化

###Version 2.1.1

* 优化内存,让所剪裁的图片快速释放！

###Version 2.1.0

* 增加带圆角的图片可以设置边框
* 增加图片缓存到内存功能、异步读取、保存图片功能、异步清除缓存功能

![image](http://www.henishuo.com/wp-content/uploads/2016/04/QQ20160407-0@2x-1-e1460027780352.png)

###Version 2.0.0

* 将UIImageView扩展中的API全部移至UIView扩展，这样可以直接使用更轻量的UIView来显示图片，而不需要UIImageView。同时还可以兼容使用UImageView的同学
* 增加几个方便生成图片的API
* 新增图片添加**边框**功能

效果如下：

![image](http://www.henishuo.com/wp-content/uploads/2016/04/QQ20160405-0@2x-e1459866017689.png)

详情查看：[Version2.0.0新增API](#Version2.0.0)

###Version 1.1.1

* fix bug
* 优化内存

###Version 1.1.0

* 增加剪裁的图片缓存管理类HYBImageClipedManager，用于解决缓存到内存引起内存增长很快的问题。详情查看**[HYBImageClipedManager](#HYBImageClipedManager)**


###Version 1.0.1

* fix文档未上传的bug
* 去掉不相关的注释
* 增加demo

#Screenshot

![image](http://www.henishuo.com/wp-content/uploads/2016/04/cliped.gif)

#裁剪花费的时间

![image](http://www.henishuo.com/wp-content/uploads/2016/04/QQ20160402-0@2x-e1459561717603.png)

正常图片裁剪所花费的时间是挺小的，但是当图片过大时，花费时间也会越多。但是，裁剪前滚动列表是非常明显地卡，裁剪后滚动是明显的流畅。对于图片列表这个demo中，裁剪后FPS能平均在58左右，基本没有感觉到卡。

#如何使用

在使用之前，先引入头文件：

```
#import "HYBImageCliped.h"
```

##<a name="HYBImageClipedManager"></a>HYBImageClipedManager

此类用于处理图片缓存到本地，解决内存增长问题。只有以下几个API，分别是读取图片、存储图片、获取缓存大小、清空缓存：

```
/**
 *	根据存储时指定的key从本地获取已剪裁好的图片
 *
 *	@param key	通常是URL。在内部会进行MD5
 *
 *	@return 从本地读取图片，不会存储到内存中，用于解决图片列表中内存暴涨问题
 */
+ (UIImage *)clipedImageFromDiskWithKey:(NSString *)key;

/**
 *	在裁剪成功后，可以调用此API，将剪裁后的图片存储到本地。
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
```

##UIImage+HYBImageCliped

目前提供了以下几种类型的API：

* 根据颜色生成图片，支持带任意圆角
* 单纯地放大或者缩小图片
* 直接生成带四个圆角的图片
* 生成带任意圆角的图片
* 直接生成圆形图片

###<a name="Version2.0.0">2.0.0新增：</a>增加添加图片边框属性

```
#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *	默认为1.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_borderWidth;
/**
 *	当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_pathWidth;
/**
 *	边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_borderColor;
/**
 *	Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_pathColor;
```

###根据颜色生成图片

下面是注释去掉后的API，可以根据颜色生成指定大小的图片，也可以设定生成带圆角的图片，当有圆角时，可以指定背景颜色，以处理图层混合问题：

```
+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize;

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)hyb_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor;
```

###单纯放大或者缩小图片

这里注释已去掉，参数一是放大或者缩小图片至targetSize，参数二是表示是否要等比例放大或者缩小。当图片的宽、高比与targetSize的宽、高比差不多时，可以使用等比例；当相关很大时，如果使用等比例，将看不到一部分内容。

```
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               isEqualScale:(BOOL)isEqualScale;
```

###直接生成带四个圆角的图片

当有圆角时，默认背景颜色为白色。为了解决图层混合所带来的性能问题，若白色与控件的背景颜色不一样，请手动指定背景颜色，以生成最适合场景的图片：

```
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成带圆角图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius;
```

###生成带任意圆角的图片

图片也可以生成带任意圆角的，比如要生成上左、上右这两个圆角，可以这么写UIRectCornerTopLeft | UIRectCornerTopRight，中间直接使用 | 来连接即可：

```
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners;
```

###直接生成圆形图片

在App中有很多是要显示成圆形的，因此使用下面的API来直接生成圆形图片是很方便的：

```
- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale;
/**
 * 生成圆形图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize;
```

##UIButton+HYBImageCliped

对于UIButton，目前提供了两种API：

* 根据状态设置图片
* 根据状态设置背景图片

###根据状态设置图片

这两个API只差一个参数targetSize，如果控件已经是明确的大小，可以直接使用不带targetSize参数的API。如果控件大小在设置图片前不确定，请手动明确指定要生成的图片的大小：

```
- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
              cornerRadius:(CGFloat)cornerRadius
              isEqualScale:(BOOL)isEqualScale;

- (void)hyb_setImage:(id)image
            forState:(UIControlState)state
              toSize:(CGSize)targetSize
        cornerRadius:(CGFloat)cornerRadius
        isEqualScale:(BOOL)isEqualScale;
```

###根据状态设置背景图片

按钮是只可以有多种状态的，可设置图片，自然也可设置背景图片：

```
- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;

- (void)hyb_setBackgroundImage:(id)image
                      forState:(UIControlState)state
                        toSize:(CGSize)targetSize
                  cornerRadius:(CGFloat)cornerRadius
                  isEqualScale:(BOOL)isEqualScale;
```

##UIView+HYBImageCliped

支持给任意视图添加带任意个圆角。使用起来也非常简单，看注释中的API介绍，带有小例子。如果有多个圆角，通过UIRectCornerTopLeft |UIRectCornerBottomRight这样来设置，中间用 | 连接，表示按位与的意思：

```
/**
 *	给控件本身添加圆角，不是通过图片实现的。
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
 * corner为UIRectCornerAllCorners 
 *
 * @Example   
 * 添加一个圆角：[view1 hyb_addCorner:UIRectCornerTopLeft cornerRadius:10];
 */
- (void)hyb_addCornerRadius:(CGFloat)cornerRadius;
```

##~~UIImageView+HYBImageCliped~~

2.0版本之后，已经添加至**UIView+HYBImageCliped**

这里提供的API也有好几种，与UIImage+HYBImageCliped有点类似：

* 将图片裁剪成指定大小（只是单纯地缩放）
* 直接生成圆形图片控件
* 生成四个带圆角图片来填充
* 生成任意圆角图片来填充

每个API后面都带有一个闭包回调，在剪裁完成时，会回传，外部可以根据需求处理。因为裁剪是异步去处理的，所以只好通过闭包回调！

###将图片裁剪成指定大小（只是单纯地缩放）

如果不需要添加任何圆角，只是想解决图片过大，与控件本身相差太大而千万像素不对齐的问题，可以直接使用下面的API：

```
- (UIImage *)hyb_setImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback;
/**
 * 使用指定的图片来填充图片。对于在填充图片之前，肯定有控件大小的，可以直接使用些API。
 */
- (UIImage *)hyb_setImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback;
```

###直接生成圆形图像

在开发中，有很多是直接显示圆形头像、圆形图片的，下面的API可以直接生成：

```
- (UIImage *)hyb_setCircleImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(HYBClipedCallback)callback;
/**
 *  使用指定的图片来填充，但是生成的是圆形图片，默认背景颜色为白色。当调用此API时，若控件本身
 *  已经有确定的大小，则可以直接使用此API
 */
- (UIImage *)hyb_setCircleImage:(id)image
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(HYBClipedCallback)callback;
```

###生成四个带圆角图片来填充

如果显示带四个圆角，可以直接使用下面的API，高效生成带圆角的且与控件大小一致的图片来填充：

```
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成带四个圆角的图片，默认使用白色背景、isEqualScale=YES
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback;

/**
 * 生成带四个圆角的图片，默认使用白色背景、isEqualScale=YES。当调用此API时，若控件本身大小是确定的，才能起效！
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback;
```

###生成任意圆角图片来填充

如果出现特殊的场景，需要生成三个圆角之类的特殊情况，或者生成上左、下左圆角或者生成上右、下右这样的组合情况时，可以通过下面的API来生成：

```
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色、isEqualScale=YES
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色、isEqualScale=YES。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback;
```

#网络下载图片处理

下面是一段通过SDWebImage来实现的异步下载图片然后剪裁后再显示的代码：

```
if (model.clipedImage) {
  self.imageView.image = model.clipedImage;
} else {
  __weak __typeof(self) weakSelf = self;
  UIImage *image = [UIImage imageNamed:@"img5.jpg"];
  [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      
      // 将剪裁后的图片记录下来，下次直接使用
      model.clipedImage = [image hyb_clipToSize:weakSelf.imageView.bounds.size
                                   cornerRadius:12
                                backgroundColor:[UIColor blackColor]
                                   isEqualScale:NO];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.imageView.image = model.clipedImage;
      });
    });
  }];
}
```

为了防止SDWebImage每次读取本地的，做了个判断，将裁剪后的图片放到模型中，下次直接使用即可！

#根据颜色生成图片使用

```
UIImageView *colorImageView = [[UIImageView alloc] init];
colorImageView.frame = CGRectMake(200, 200, 80, 100);
[self.view addSubview:colorImageView];
colorImageView.image = [UIImage hyb_imageWithColor:[UIColor greenColor] toSize:CGSizeMake(80, 100) cornerRadius:20];
```

#按钮使用

```
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
button.frame = CGRectMake(100, 200, 80, 80);
button.backgroundColor = [UIColor whiteColor];
[self.view addSubview:button];
[button hyb_setImage:@"img1.jpeg" forState:UIControlStateNormal cornerRadius:40 isEqualScale:YES];
[button hyb_setImage:@"bimg5.jpg" forState:UIControlStateHighlighted cornerRadius:40 isEqualScale:NO];
```

#UIImageView使用

生成圆形图片：

```
[imgView hyb_setCircleImage:@"img1.jpeg" isEqualScale:YES onCliped:^(UIImage *clipedImage) {
    
}];
```

#任意圆角

```
UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 80, 80)];
view1.backgroundColor = [UIColor greenColor];

// 只加左上角
[view1 hyb_addCorner:UIRectCornerTopLeft cornerRadius:10];

[self.view addSubview:view1];
  
UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
view2.backgroundColor = [UIColor greenColor];

// 只添加右
[view2 hyb_addCorner:UIRectCornerTopRight cornerRadius:10];
[self.view addSubview:view2];

UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 80, 80)];
view3.backgroundColor = [UIColor greenColor];

// 只添加下左角和下右角
[view3 hyb_addCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:10];
[self.view addSubview:view3];
```

#如何安装

支持Pod安装，可直接将下面的代码放到Podfile中：

```
pod 'HYBImageCliped', '~> 2.0.0'
```

或者到GITHUB直接下载【[HYBImageCliped](https://github.com/CoderJackyHuang/HYBImageCliped)】将其中的Sources目录放入到工程！

#LICENSE

**MIT LICENSE**







