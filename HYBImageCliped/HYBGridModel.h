//
//  HYBGridModel.h
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYBGridModel : NSObject

//@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;

// 剪裁后的图片
@property (nonatomic, strong) UIImage *clipedImage;

@end
