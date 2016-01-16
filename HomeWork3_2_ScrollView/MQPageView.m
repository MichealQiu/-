//
//  MQPageView.m
//  HomeWork3_2_ScrollView
//
//  Created by Michael Qiu on 16/1/16.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

#import "MQPageView.h"

@interface MQPageView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MQPageView

#pragma mark - 初始化方法
/**
 *  当控件通过代码创建时，就会调用这个方法
 *  当控件通过代码创建是，想做一些初始化操作，应该在这个方法中执行
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  当控件从xib\storyboard中创建完毕时，就会调用这个方法
 *  当控件从xib\storyboard中创建完毕后的初始化操作，应该放在这个方法中执行
 */
- (void)awakeFromNib {
    [self setup];
}

/**
 *  初始化方法
 */
- (void)setup {
    self.scrollView.backgroundColor = [UIColor redColor];
//    开启定时器
    [self startTimer];

    
}

+ (instancetype)pageView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 *  当控件的尺寸发生改变的时候，会自动调用这个方法
 */
- (void)layoutSubviews {
    [super layoutSubviews];
//    设置scrollView的frame
    self.scrollView.frame = self.bounds;
//    获得scrollView的尺寸
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;

//    设置pageControl
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = (scrollW - pageW) / 2;
    CGFloat pageY = scrollH - pageH;
    self.pageController.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
//    设置内容大小
    self.scrollView.contentSize = CGSizeMake(self.imageNames.count * scrollW, 0);
    
//    设置所有imageView的frame
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
}

#pragma mark - setter方法的重写
- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
//    移除直接的所有imageView
//    让subViews数组中的所有对象都执行removeFromSuperView方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    根据图片名创建对应个数的imageView
    for (int i = 0; i < imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [self.scrollView addSubview:imageView];
    }
    
//    设置总页数
    self.pageController.numberOfPages = imageNames.count;
}

- (void)setCurrentColor:(UIColor *)currentColor {
    _currentColor = currentColor;
    self.pageController.currentPageIndicatorTintColor = currentColor;
}

- (void)setOtherColor:(UIColor *)otherColor {
    _otherColor = otherColor;
    self.pageController.pageIndicatorTintColor = otherColor;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageController.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark - 定时器控制
- (void)startTimer {
//    创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  下一页
 */
- (void)nextPage {
    NSInteger page = self.pageController.currentPage + 1;
    if (page == self.pageController.numberOfPages) {
        page = 0;
    }
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}
@end
