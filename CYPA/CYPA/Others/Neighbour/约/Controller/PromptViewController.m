//
//  PromptViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/11.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PromptViewController.h"
#import "Header.h"

@interface PromptViewController ()

@property(nonatomic, strong)UIButton * sureBT;
@property(nonatomic, strong)UIButton * inviteBT;

@end

@implementation PromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupViews];
    
}

-(void)setupViews {
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(210));
    }];

    //标题
    UILabel * titileLabel = [[UILabel alloc] init];
    titileLabel.text = @"报名成功";
    titileLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:titileLabel];
    
    [titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //成功
    UIImageView * correctImv = [[UIImageView alloc] init];
    correctImv.image = [UIImage imageNamed:@"correct"];
    [view addSubview:correctImv];
    
    [correctImv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titileLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(50)));
    }];
    
    //确认
    _sureBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _sureBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _sureBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _sureBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _sureBT.layer.masksToBounds = YES;
    [_sureBT setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.view addSubview:_sureBT];
    [_sureBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(-12.5));
        make.bottom.mas_equalTo(view.mas_bottom).offset(SIZE_SCALE_IPHONE6(-30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(84), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_sureBT addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //邀请好友
    _inviteBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _inviteBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _inviteBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _inviteBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _inviteBT.layer.masksToBounds = YES;
    [_inviteBT setTitle:@"邀请好友" forState:(UIControlStateNormal)];
    [self.view addSubview:_inviteBT];
    [_inviteBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(12.5));
        make.bottom.mas_equalTo(_sureBT.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(84), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_inviteBT addTarget:self action:@selector(inviteAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

-(void)sureAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//邀请
-(void)inviteAction {
    
    FriendListViewController * friendVC = [[FriendListViewController alloc] init];
    friendVC.UID = self.UID;
    friendVC.GroupID = self.GroupID;
    
    [self.navigationController pushViewController:friendVC animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
