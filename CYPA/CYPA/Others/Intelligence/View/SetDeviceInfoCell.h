//
//  SetDeviceInfoCell.h
//  CYPA
//
//  Created by 张雨 on 2017/5/12.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetDeviceInfoCellDelegate <NSObject>

-(void)changeDeviceIdWithType:(NSString *)type number:(NSString *)number;
-(void)changePriceWithPrice:(NSString *)price;
-(void)changeFluxSumWithPrice:(NSString *)price;

@end

@interface SetDeviceInfoCell : UITableViewCell
@property (nonatomic, strong) UIImageView *mIconImg;
@property (nonatomic, strong) UILabel *mTitleLabel;
@property (nonatomic, strong) UILabel *mSetDeviceIdTitleLab;
@property (nonatomic, strong) UITextField *mSetDeviceIdTypeText;
@property (nonatomic, strong) UITextField *mSetDeviceIdNumberText;
@property (nonatomic, strong) UILabel *mSetPriceTitleLab;
@property (nonatomic, strong) UITextField *mSetPriceText;
@property (nonatomic, strong) UILabel *mFluxSumTitleLab;
@property (nonatomic, strong) UITextField *mFluxSumText;
@property (nonatomic, strong) UIButton *mDownBtn;

@property (nonatomic, strong) id <SetDeviceInfoCellDelegate> mDelegate;

@end
