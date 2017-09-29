//
//  QueryDeviceCell.h
//  CYPA
//
//  Created by 张雨 on 2017/5/12.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryDeviceCell : UITableViewCell
@property (nonatomic, strong) UIImageView *mIconImg;
@property (nonatomic, strong) UILabel *mTitleLab;
@property (nonatomic, strong) UILabel *mNumberLab;
@property (nonatomic, assign) NSString * number;
@end
