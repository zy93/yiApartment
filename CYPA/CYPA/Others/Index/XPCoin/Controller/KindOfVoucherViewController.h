//
//  KindOfVoucherViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/4.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface KindOfVoucherViewController : BaseTitleViewController

@property (nonatomic,strong)NSString * money;

//@property(nonatomic, assign)NSInteger voucherNum; //缴费的类型
@property(nonatomic, assign)NSInteger payType; //支付的类型(充值  0/缴费  1)


@property(nonatomic, strong)NSString *billIDString; //账单ID


@end
