//
//  ActivityDetailViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "TrystModel.h"

@interface ActivityDetailViewController : BaseTitleViewController

@property (nonatomic,strong)TrystModel * activityModel;
@property(nonatomic, strong)NSString * GroupID;

@end
