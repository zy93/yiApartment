//
//  AITSwitchTableViewCell.m
//  CYPA
//
//  Created by 张雨 on 2017/5/15.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "AITSwitchTableViewCell.h"
#import "Header.h"
#import "AITTwoSwitch.h"
#import "AITCurtain.h"


@interface AITSwitchTableViewCell ()

@property (nonatomic, strong) UIImageView *mIconImg;
@property (nonatomic, strong) UISwitch *mSwitch;
@property (nonatomic, strong) UILabel *mTitleLab;
@property (nonatomic, strong) UIView *mBGView;
@property (nonatomic, strong) NSMutableArray *mSwitchArr;
@end


@implementation AITSwitchTableViewCell
\
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self setupView];
        _mSwitchArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setMSwitchType:(SWITCH_TYPE)mSwitchType
{
    _mSwitchType = mSwitchType;
    [self.mSwitchArr removeAllObjects];
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self setupView];
}

-(void)setupView
{
    self.mIconImg = [UIImageView new];
    [self.mIconImg setImage:[UIImage imageNamed:_mDeviceType==AIT_DEVICE_TYPE_CURTAIN?@"窗帘icon":@"三键icon"]];
    [self.contentView addSubview:self.mIconImg];
    
    self.mTitleLab = [UILabel new];
    self.mTitleLab.text = _mDeviceType==AIT_DEVICE_TYPE_CURTAIN?@"窗帘":_mSwitchType==SWITCH_TYPE_THREE?@"三键开关":@"二键开关";
    [self.contentView addSubview:self.mTitleLab];
    
    self.mSwitch = [UISwitch new];
    [self.mSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.mSwitch];
    
    self.mBGView = [UIView new];
    [self.mBGView setBackgroundColor:UIColorHEX(0xf2f2f3)];
    [self.contentView addSubview:self.mBGView];
    for (int i = 0; i<(_mDeviceType==AIT_DEVICE_TYPE_CURTAIN?3:_mSwitchType); i++) {
        UIButton *btn = [UIButton new];
        NSString *imStr =_mDeviceType==AIT_DEVICE_TYPE_CURTAIN?(i==0?@"窗帘关":i==1?@"暂停":@"窗帘开"):@"开关";
        btn.tag = 1000+i;
        [btn setImage:[UIImage imageNamed:imStr] forState:UIControlStateNormal];
        UIImage *hightImg = [btn.imageView.image imageWithColor:UIColorHex(0x52d765)];
        [btn setImage:hightImg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.mBGView addSubview:btn];
        [self.mSwitchArr addObject:btn];
    }
//    [self setNeedsUpdateConstraints];

}

-(void)layoutSubviews
{
    
    [self.mIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(32), SIZE_SCALE_IPHONE6(29)));
        
    }];
    
    [self.mTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mIconImg.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.mIconImg.mas_centerY);
    }];
    
    [self.mSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.mas_equalTo(self.mIconImg.mas_centerY);
    }];
    
    
    [self.mBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 15, 15, -15));
        make.top.mas_equalTo(self.mIconImg.mas_bottom).with.offset(10).with.priorityHigh();;
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.bottom.mas_equalTo(-SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(-SIZE_SCALE_IPHONE6(15));
    }];
    
    UIView *upView = self.mBGView;
    UIView *nextView = nil;
    
    for (int i = 0; i<self.mSwitchArr.count; i++) {
        UIButton *btn = self.mSwitchArr[i];
//        [btn setBackgroundColor:[UIColor redColor]];
        if (i==0) {  //第一个
            nextView = self.mSwitchArr[i+1];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(upView.mas_top);
                make.left.mas_equalTo(self.mBGView.mas_left).with.offset(SIZE_SCALE_IPHONE6(30));
                make.right.mas_equalTo(nextView.mas_left);
                make.width.mas_equalTo(nextView.mas_width);
                make.height.mas_equalTo(self.mBGView.mas_height);
            }];
//            [btn setBackgroundColor:UIColorHEX(0x12ff56)];
            upView = btn;
            
        }
        else if (i==self.mSwitchArr.count-1) {  //最后一个
            nextView = self.mBGView;
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(upView.mas_top);
                make.left.mas_equalTo(upView.mas_right);
                make.right.mas_equalTo(self.mBGView.mas_right).with.offset(-SIZE_SCALE_IPHONE6(30));
                make.width.mas_equalTo(upView.mas_width);
                make.height.mas_equalTo(self.mBGView.mas_height);
                
            }];
            upView = btn;
//            [btn setBackgroundColor:UIColorHEX(0xff3456)];
        }
        else {  //其他
            nextView = self.mSwitchArr[i+1];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(upView.mas_top);
                make.left.mas_equalTo(upView.mas_right);
                make.right.mas_equalTo(nextView.mas_left);
                make.width.mas_equalTo(upView.mas_width);
                make.height.mas_equalTo(upView.mas_height);
            }];
//            [btn setBackgroundColor:UIColorHEX(0x123456)];
            upView = btn;
        }
        
    }


}

-(void)switchAction:(UISwitch *)sender
{
    //窗帘
    if (_mDeviceType == AIT_DEVICE_TYPE_CURTAIN) {
        [(AITCurtain *)_mDevice setControlWithValue:sender.isOn?AITCURTAIN_TYPE_On:AITCURTAIN_TYPE_Off response:^(NSDictionary *dic) {
            NSLog(@"---窗帘控制回复:%@", dic);
        }];
    }
    //开关
    else {
        for (UIButton *btn in _mSwitchArr) {
            NSInteger i = btn.tag - 999;
            [(AITTwoSwitch *)_mDevice setControlWithValue:sender.isOn lightId:i response:^(NSDictionary *dic) {
                NSLog(@"----开关控制回复:%@", dic);
            }];
        }
    }
}

-(void)clickButton:(UIButton *)sender
{
    if (_mDeviceType == AIT_DEVICE_TYPE_CURTAIN) {
        switch (sender.tag) {
            case 1000:
            {
                [(AITCurtain *)_mDevice setControlWithValue:AITCURTAIN_TYPE_Off response:^(NSDictionary *dic) {
                    NSLog(@"---窗帘关回复:%@", dic);
                }];
                sender.selected = YES;
                UIButton *btn1 = [self viewWithTag:1001];
                btn1.selected = NO;
                UIButton *btn2 = [self viewWithTag:1002];
                btn2.selected = NO;

            }
                break;
            case 1001:
            {
                [(AITCurtain *)_mDevice setControlWithValue:AITCURTAIN_TYPE_Off response:^(NSDictionary *dic) {
                    NSLog(@"---窗帘暂停控制回复:%@", dic);
                }];
                sender.selected = YES;
            }
                break;
            case 1002:
            {
                [(AITCurtain *)_mDevice setControlWithValue:AITCURTAIN_TYPE_On response:^(NSDictionary *dic) {
                    NSLog(@"---窗帘开回复:%@", dic);
                }];
                sender.selected = YES;
                UIButton *btn1 = [self viewWithTag:1000];
                btn1.selected = NO;
                UIButton *btn2 = [self viewWithTag:1001];
                btn2.selected = NO;
            }
                break;
                
            default:
                break;
        }
    }
    //开关
    else {
        NSInteger i = sender.tag - 999;
        [(AITTwoSwitch *)_mDevice setControlWithValue:sender.isSelected lightId:i response:^(NSDictionary *dic) {
            NSLog(@"----开关独立控制回复:%@", dic);
        }];
    }
}

@end
