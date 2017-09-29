//
//  OutLetsPayViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"

@protocol NextViewControllerDelegate <NSObject>

//定义一个方法，参数就是要传的值
-(void)passValue:(NSMutableArray *)showArray dataArray:(NSMutableArray *)addArray;
@end

@interface OutLetsPayViewController : BaseTitleViewController

@property(nonatomic, strong)NSMutableArray * addArray;
@property(nonatomic, strong)NSMutableArray * showArray;
@property(nonatomic, strong)NSString * FID;

//声明代理
@property(nonatomic,assign)id<NextViewControllerDelegate>delegate;


@end
