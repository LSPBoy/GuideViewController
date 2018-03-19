//
//  GuideViewController.h
//  GuideViewController
//
//  Created by zhudou on 2018/3/19.
//  Copyright © 2018年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishBtnClickBlock)(void);

@interface GuideViewController : UIViewController

/**
 类方法实例化

 @param imageNameArray 图片名称数组
 @param finishBtnTitle 最后一个界面的按钮
 @param block 点击最后一个按钮的回调
 @return GuideViewController
 */
+ (instancetype)guideWithImageNameArray:(NSArray <NSString *>*)imageNameArray finishBtnTitle:(NSString *)finishBtnTitle finishBtnBlock:(finishBtnClickBlock)block;


/**
 是否隐藏PageControl 默认NO
 */
@property (nonatomic,assign) BOOL isHiddenPageControl;

/**
 是否隐藏FinishBtn 默认NO
 */
@property (nonatomic,assign) BOOL isHiddenFinishBtn;


@end
