//
//  CheckPasswordViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/4/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface CheckPasswordViewController : BaseTitleViewController

@property(nonatomic, assign)double sumMoney;
@property(nonatomic, strong)NSMutableArray * addArray;
@property(nonatomic, strong)NSMutableArray * showArray;

@property(nonatomic, strong)NSString * billIDString;
@property(nonatomic, assign)int totalMoney;


@end
