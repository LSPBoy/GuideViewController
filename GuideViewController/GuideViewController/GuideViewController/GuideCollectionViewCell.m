//
//  GuideCollectionViewCell.m
//  GuideViewController
//
//  Created by zhudou on 2018/3/19.
//  Copyright © 2018年 lsp. All rights reserved.
//

#import "GuideCollectionViewCell.h"

//完成按钮距离下方的距离
#define FinishBtnToBottom 100.0
#define FinishBtnWidth 150
#define FinishBtnHeight 60
@interface GuideCollectionViewCell ()



@end

@implementation GuideCollectionViewCell

- (UIButton *)finishBtn {
    if (_finishBtn == nil) {
       _finishBtn = [UIButton new];
        _finishBtn.backgroundColor = [UIColor greenColor];
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.layer.cornerRadius = 22.f;
    }
    return _finishBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.finishBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;

    CGFloat btnHeight = FinishBtnHeight;
    CGFloat btnWidth = FinishBtnWidth;
    CGFloat btnX = (self.bounds.size.width - btnWidth)/2;
    CGFloat btnY = self.bounds.size.height - FinishBtnToBottom - btnHeight;
    self.finishBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
}

@end
