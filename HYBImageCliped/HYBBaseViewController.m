//
//  HYBBaseViewController.m
//  HYBTransitionAnimations
//
//  Created by huangyibiao on 16/3/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBaseViewController.h"

@implementation HYBBaseViewController

- (instancetype)initWithTitle:(NSString *)title {
  if (self = [super init]) {
    self.title = title;
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
