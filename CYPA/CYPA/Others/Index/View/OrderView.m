//
//  OrderView.m
//  MyOrderView
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "OrderView.h"
#import "Header.h"
#import "BussnessPatenerModel.h"
@interface OrderView()<UIScrollViewDelegate>

@property (nonatomic, copy)NSString *centerImageNamged;

@property (nonatomic, copy)NSString *leftImageNamed;

@property (nonatomic, copy)NSString *rightImageNamed;

@property (nonatomic, strong)UIImageView *centerImageView;

@property (nonatomic, strong)UIImageView *leftImageView;

@property (nonatomic, strong)UIImageView *rightImageView;

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)NSMutableArray *imageArray;

// 页码
@property (nonatomic, assign)NSInteger page;

//@property (nonatomic, strong)UIButton *button;

@end

@implementation OrderView

- (void)bindImageArray:(NSArray *)imageArray
{
    self.imageArray = [NSMutableArray arrayWithArray:imageArray];
    
    // 把scrollView添加到自己的视图上
    [self addSubview:self.scrollView];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 把三个图片添加到scrollView上
    [self.scrollView addSubview:self.leftImageView];
    
    [self.scrollView addSubview:self.centerImageView];
    
    [self.scrollView addSubview:self.rightImageView];
    
    // 保证刚出现的时候，正中间显示的是第一张图片
    // 左边显示最后一张
    // 右边显示第二张
    // 核心思想：图片不动，动数据
    self.centerImageNamged = self.imageArray[0];
    if (self.imageArray.count > 1) {
        self.rightImageNamed = self.imageArray[1];
    } else {
        self.rightImageNamed = self.imageArray[0];
    }
    self.leftImageNamed = self.imageArray[self.imageArray.count-1];
    
    // 把图片放到imageView上
    // 对应位置的imageView方对应的图片
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.centerImageNamged] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.leftImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.rightImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    
    // pageControll
    self.pc = [[UIPageControl alloc] init];
    self.pc.frame = CGRectMake(0.5*self.frame.size.width - 60, CGRectGetMaxY(self.scrollView.frame) + SIZE_SCALE_IPHONE6(10), 120, SIZE_SCALE_IPHONE6(5));
    
    self.pc.numberOfPages = self.imageArray.count;
    
    self.pc.pageIndicatorTintColor = [UIColor grayColor];
    self.pc.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"666666"];
    
    [self addSubview:self.pc];
    self.page = 0;
    self.pc.userInteractionEnabled = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoAction) userInfo:nil repeats:YES];
    
}


- (void)autoAction
{
    
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * 2, 0);
    }];
    [self scrollViewDidEndDecelerating:self.scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 向右滚动
    if (scrollView.contentOffset.x == 0) {
        // 替换数据源
        // 让centerImageNamed保存的是leftImageNamed
        // 让rightImageNamed保存的是centerImageNamed
        // 更新leftImageNamed的数据
        
        // 先替换rightImageNamed在替换centerImageNamed
        _rightImageNamed = _centerImageNamged;
        _centerImageNamged = _leftImageNamed;
        
        NSInteger index = [self imageOnImageArrayWithImageString:_leftImageNamed];
        
        if (index == 0) {
            _leftImageNamed = self.imageArray[self.imageArray.count - 1];
        }else{
            _leftImageNamed = self.imageArray[index -1];
        }
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.centerImageNamged] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.leftImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.rightImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
        
        // pageControl
        self.pc.currentPage = self.page -= 1;
        if (self.page == -1) {
            self.page = 4;
            self.pc.currentPage = self.page;
        }
        
    }else {
        
        _leftImageNamed = _centerImageNamged;
        _centerImageNamged = _rightImageNamed;
        NSInteger index = [self imageOnImageArrayWithImageString:self.rightImageNamed];
        
        if (index == self.imageArray.count - 1) {
            self.rightImageNamed = self.imageArray[0];
        }else{
            self.rightImageNamed = self.imageArray[index + 1];
        }
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.centerImageNamged] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.leftImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.rightImageNamed] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
        
        
        
        self.pc.currentPage = self.page += 1;
        
        if (self.page == self.imageArray.count) {
            self.page = 0;
            self.pc.currentPage = self.page;
        }
    }
}

- (NSInteger)imageOnImageArrayWithImageString:(NSString *)imageString
{
    for (int i = 0; i < self.imageArray.count; i++) {
        if ([imageString isEqualToString:self.imageArray[i]]) {
            return i;
        }
    }
    return 0;
}

- (UIImageView *)centerImageView
{
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
    }
    return _centerImageView;
}



- (UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    }
    
    return _leftImageView;
}
- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * 2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    }

    return _rightImageView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.bounds;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
        
        
    }
    return _scrollView;
}
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        
    }
    return _imageArray;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
