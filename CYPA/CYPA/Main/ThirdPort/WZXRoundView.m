//
//  WZXRoundView.m
//  WZXroundDemo
//
//  Created by wordoor－z on 15/11/24.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "WZXRoundView.h"


@implementation WZXRoundView
{
    NSMutableArray * _dataArr;
    CGPoint _centerPt;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _dataArr = [[NSMutableArray alloc]init];
        
        self.backgroundColor = [UIColor clearColor];
        
        _centerPt = self.center ;
        
        [self drawRect:self.frame];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andArr:(NSArray *)arr
{
    if (self == [super initWithFrame:frame])
    {
        _dataArr = [[NSMutableArray alloc]initWithArray:arr];
        
        self.backgroundColor = [UIColor clearColor];
        
        _centerPt = self.center ;
        
        [self drawRect:self.frame];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    CGFloat start = 0;
    CGFloat sum = 0;
    
    for (NSDictionary * dic in _dataArr)
    {
        NSString * numStr = dic[@"num"];
        sum += [numStr floatValue];
    }
  
    for (int i = 0; i < _dataArr.count; i++)
    {
        NSDictionary * dic = _dataArr[i];
        
        NSString * numStr = dic[@"num"];
        
        UIColor * color = dic[@"color"];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, _centerPt.x, _centerPt.y);
        
        CGContextSetFillColorWithColor(context,[color CGColor]);
        
        CGContextAddArc(context, _centerPt.x, _centerPt.y, self.frame.size.width/2.0, [self degreesToRadians:start], [self degreesToRadians:([numStr floatValue]/sum)*360 + start], 0);
        
        CGContextClosePath(context);
        
        CGContextFillPath(context);
        
        start +=([numStr floatValue]/sum)*360 ;
        
    }
   
}
-(void)addNum:(NSString *)num forColor:(UIColor *)color
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:num forKey:@"num"];
    [dic setObject:color forKey:@"color"];
    [_dataArr addObject:dic];
    [self setNeedsDisplay];
}

-(CGFloat)degreesToRadians:(CGFloat)degrees
{
    return degrees * M_PI / 180;
}
@end
