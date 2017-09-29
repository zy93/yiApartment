//
//  PersonShowViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BasePersonViewController.h"
#import "UPerson.h"
@interface PersonShowViewController : BasePersonViewController
@property (nonatomic,strong)UPerson * personModel;

@property(nonatomic, strong)NSString * UID;

@end
