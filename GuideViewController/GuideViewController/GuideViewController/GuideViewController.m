//
//  GuideViewController.m
//  GuideViewController
//
//  Created by zhudou on 2018/3/19.
//  Copyright © 2018年 lsp. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideCollectionViewCell.h"

//PageControl距离下方的距离  根据自己的需求进行调整
#define PageControlToBottom 50

@interface GuideViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,copy) NSString *finishBtnTitle;

@property (nonatomic,copy) finishBtnClickBlock block;


@end

@implementation GuideViewController

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:NSClassFromString(@"GuideCollectionViewCell") forCellWithReuseIdentifier:@"cellID"];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.imageNameArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.currentPage = 0;
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:5];
        CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width)/2;
        CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - PageControlToBottom);
        _pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
    }
    return _pageControl;
}

+ (instancetype)guideWithImageNameArray:(NSArray<NSString *> *)imageNameArray finishBtnTitle:(NSString *)finishBtnTitle finishBtnBlock:(finishBtnClickBlock)block
{
    GuideViewController *guide = [[GuideViewController alloc] init];
    guide.block = block;
    guide.finishBtnTitle = finishBtnTitle;
    guide.imageNameArray = imageNameArray;
    return guide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    if (!self.isHiddenPageControl)
    {
        [self.view addSubview:self.pageControl];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    
    [cell.finishBtn setTitle:self.finishBtnTitle forState:UIControlStateNormal];
    
    if (indexPath.row != self.imageNameArray.count - 1)
    {
        cell.finishBtn.hidden = YES;
        cell.finishBtn.userInteractionEnabled = NO;
        
    }else
    {
        // 随后一页 显示按钮, 并且添加响应方法
        cell.finishBtn.hidden = self.isHiddenFinishBtn;
        cell.finishBtn.userInteractionEnabled = !self.isHiddenFinishBtn;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return cell;
}

- (void)finishBtnOnClick:(UIButton *)finishBtn {
    if (self.block) {
        self.block();
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage)
    {
        self.pageControl.currentPage = currentPage;
    }
}




@end
