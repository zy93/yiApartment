//
//  OrderView.h
//  MyOrderView
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView

@property (nonatomic, strong)UIPageControl *pc;

- (void)bindImageArray:(NSArray *)imageArray;

@end
