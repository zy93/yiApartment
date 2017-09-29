//
//  PersonIntroduceCell.h
//  CYPA
//
//  Created by HDD on 16/7/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPerson.h"

@interface PersonIntroduceCell : UITableViewCell

@property(nonatomic, strong)UPerson *personModel;
@property(nonatomic, strong)UIButton *knockBT; //敲门
@property(nonatomic, strong)UIImageView *headImv;//头像

@end
