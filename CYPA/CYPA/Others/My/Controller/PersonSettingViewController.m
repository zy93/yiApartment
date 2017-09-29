//
//  PersonSettingViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/12.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonSettingViewController.h"
#import "Header.h"

@interface PersonSettingViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong)UIButton * headBT;
@property(nonatomic, strong)UITextField * nameTF;

@property(nonatomic, strong)UIButton * manButton;
@property(nonatomic, strong)UIButton * womenButton;
@property(nonatomic, assign)NSInteger sexChange;
@property(nonatomic, strong)UITextField * ageTF;
@property(nonatomic, strong)UILabel * constellationLB;
@property(nonatomic, strong)UITableView * conTableView;
@property(nonatomic, strong)UITextView * introTextView;
@property(nonatomic, strong)UILabel * placeholderLabel;
@property(nonatomic, strong)UIButton * publishBT;
@property(nonatomic, strong)UITextField * countryTF;
@property(nonatomic, strong)UITextField * cityTF;
@property(nonatomic, strong)UILabel * hobbyLB;
@property(nonatomic, strong)UITableView * hobbyTableView;
@property(nonatomic, strong)UIImagePickerController * picker;
@property(nonatomic, strong)NSString * headImageString;
@property(nonatomic, strong)XPCitizen * citizenModel;


@end

@implementation PersonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
    


}

-(void)setupViews{
    
    UILabel * headLabel = [[UILabel alloc] init];
    headLabel.text = @"头像:";
    headLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:headLabel];
    
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(12));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //头像
    _headBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _headImv.backgroundColor = [UIColor cyanColor];
    _headBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(48);
    _headBT.layer.masksToBounds = YES;
    [_headBT setImage:[UIImage imageNamed:@"970"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.headBT];
    
    [_headBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(27));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(96), SIZE_SCALE_IPHONE6(96)));
    }];
    
    [_headBT addTarget:self action:@selector(selectHeadImage) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UILabel * headLabel1 = [[UILabel alloc] init];
    headLabel1.text = @"求真相";
    headLabel1.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
    [self.view addSubview:headLabel1];
    
    [headLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(6));
        make.centerX.mas_equalTo(self.headBT.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    //昵称
    UILabel * nickLabel = [[UILabel alloc] init];
    nickLabel.text = @"昵称";
    nickLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:nickLabel];
    
    [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(165));
        make.left.mas_equalTo(headLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    self.nameTF = [[UITextField alloc] init];
    self.nameTF.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.nameTF.placeholder = @"请输入您的姓名";
    [self.view addSubview:self.nameTF];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nickLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(120));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-100));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //性别
    UILabel * sexLabel = [[UILabel alloc] init];
    sexLabel.text = @"性别：";
    sexLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:sexLabel];
    
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nickLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(headLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.sexChange = 0;
    
    //男button
    self.manButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.manButton setImage:[UIImage imageNamed:@"969"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.manButton];
    
    [self.manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sexLabel.mas_centerY);
        make.right.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(-5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(22)));
    }];
    
    [self.manButton addTarget:self action:@selector(manAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //女button
    self.womenButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.womenButton setImage:[UIImage imageNamed:@"968"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.womenButton];
    
    [self.womenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.manButton.mas_top);
        make.left.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(22)));
    }];
    
    [self.womenButton addTarget:self action:@selector(womenAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //年龄
    UILabel * ageLabel = [[UILabel alloc] init];
    ageLabel.text = @"年龄";
    ageLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:ageLabel];
    
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sexLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(sexLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    self.ageTF = [[UITextField alloc] init];
    self.ageTF.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.ageTF.placeholder = @"请输入年龄";
    self.ageTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.ageTF];
    
    [self.ageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ageLabel.mas_centerY);
        make.left.mas_equalTo(self.nameTF.mas_left);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-100));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //家乡
    UILabel * homeLabel = [[UILabel alloc] init];
    homeLabel.text = @"家乡";
    homeLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:homeLabel];
    
    [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ageLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(ageLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    self.countryTF = [[UITextField alloc] init];
    self.countryTF.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.countryTF.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.countryTF.placeholder = @"国家";
    [self.view addSubview:self.countryTF];
    
    [self.countryTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(homeLabel.mas_centerY);
        make.left.mas_equalTo(self.nameTF.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(20)));
        
    }];
    
    self.cityTF = [[UITextField alloc] init];
    self.cityTF.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.cityTF.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.cityTF.placeholder = @"城市";
    [self.view addSubview:self.cityTF];
    
    [self.cityTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(homeLabel.mas_centerY);
        make.left.mas_equalTo(self.countryTF.mas_right).offset(SIZE_SCALE_IPHONE6(25));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(20)));
        
    }];

    
    //兴趣爱好
    UILabel * hobbyLabel = [[UILabel alloc] init];
    hobbyLabel.text = @"兴趣：";
    hobbyLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:hobbyLabel];
    
    [hobbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(homeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(homeLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.hobbyLB = [[UILabel alloc] init];
    self.hobbyLB.text = @"兴趣爱好";
    self.hobbyLB.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    self.hobbyLB.layer.masksToBounds = YES;
    self.hobbyLB.textColor = [UIColor colorWithRed:183/255.0 green:183/255.0  blue:183/255.0  alpha:1];
    self.hobbyLB.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.hobbyLB.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:self.hobbyLB];
    
    [self.hobbyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hobbyLabel.mas_centerY);
        make.left.mas_equalTo(self.ageTF.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(20)));
    }];
    
    
    UIButton * selectBT1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectBT1 setImage:[UIImage imageNamed:@"965"] forState:(UIControlStateNormal)];
    [self.view addSubview:selectBT1];
    
    [selectBT1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.hobbyLB.mas_centerY);
        make.left.mas_equalTo(self.hobbyLB.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(5)));
    }];
    
    [selectBT1 addTarget:self action:@selector(selectHobby) forControlEvents:(UIControlEventTouchUpInside)];
    
    

    //星座
    UILabel * constellationLabel = [[UILabel alloc] init];
    constellationLabel.text = @"星座：";
    constellationLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:constellationLabel];
    
    [constellationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hobbyLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(hobbyLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.constellationLB = [[UILabel alloc] init];
    self.constellationLB.text = @"选择星座";
    self.constellationLB.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    self.constellationLB.textColor = [UIColor colorWithRed:183/255.0 green:183/255.0  blue:183/255.0  alpha:1];
    self.constellationLB.layer.masksToBounds = YES;
    self.constellationLB.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.constellationLB.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [self.view addSubview:self.constellationLB];
    
    [self.constellationLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(constellationLabel.mas_top);
        make.left.mas_equalTo(self.ageTF.mas_left);
        make.right.mas_equalTo(selectBT1.mas_right);
    }];
    
    UIButton * selectBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectBT setImage:[UIImage imageNamed:@"965"] forState:(UIControlStateNormal)];
    [self.view addSubview:selectBT];
    
    [selectBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.constellationLB.mas_centerY);
        make.left.mas_equalTo(self.constellationLB.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(5)));
    }];
    
    [selectBT addTarget:self action:@selector(selectConstellation) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
        //签名
    UILabel * introLabel = [[UILabel alloc] init];
    introLabel.text = @"签名：";
    introLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
    [self.view addSubview:introLabel];
    
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(constellationLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(ageLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.introTextView = [[UITextView alloc] init];
    self.introTextView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.introTextView.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
    self.introTextView.delegate = self;
    [self.view addSubview:self.introTextView];
    
    [self.introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(70));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(90));
    }];
    
    //textview的placeholder
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
    self.placeholderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.text = @"  描述还可以输入100个字";
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.introTextView addSubview:self.placeholderLabel];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(275), SIZE_SCALE_IPHONE6(40)));
    }];

    //确认
    _publishBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _publishBT.backgroundColor = [UIColor redColor];
    _publishBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _publishBT.titleLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    _publishBT.layer.masksToBounds = YES;
    [_publishBT setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.view addSubview:_publishBT];
    [_publishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.introTextView.mas_bottom).offset(SIZE_SCALE_IPHONE6(30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(84), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_publishBT addTarget:self action:@selector(publishAction) forControlEvents:(UIControlEventTouchUpInside)];

    //选择爱好
    self.hobbyTableView = [[UITableView alloc] init];
    self.hobbyTableView.delegate = self;
    self.hobbyTableView.dataSource = self;
    self.hobbyTableView.hidden = YES;
    self.hobbyTableView.tag = 1110;
    [self.view addSubview:self.hobbyTableView];
    self.hobbyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.hobbyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL_hobby"];
    
    [self.hobbyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hobbyLB.mas_bottom);
        make.left.mas_equalTo(self.hobbyLB.mas_left);
        make.right.mas_equalTo(selectBT1.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(180));
    }];
    
    //选择星座
    self.conTableView = [[UITableView alloc] init];
    self.conTableView.delegate = self;
    self.conTableView.dataSource = self;
    self.conTableView.hidden = YES;
    self.conTableView.tag = 1111;
    [self.view addSubview:self.conTableView];
    self.conTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.conTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL_constellation"];
    
    [self.conTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.constellationLB.mas_bottom);
        make.left.mas_equalTo(self.constellationLB.mas_left);
        make.right.mas_equalTo(selectBT.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(180));
    }];
    
}

//添加头像
-(void)selectHeadImage {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertView * warning = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [warning show];
            
        }else
        {
            self.picker = [[UIImagePickerController alloc]init];
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.delegate = self;
            self.picker.allowsEditing = YES;
            
            [self presentViewController:self.picker animated:YES completion:nil];
            
            
        }
        
    }];
    
    [alertController addAction:camera];
    
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        [self pickImageWithType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        
        self.picker = [[UIImagePickerController alloc]init];
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
        
        [self presentViewController:self.picker animated:YES completion:nil];
        
        
        
    }];
    [alertController addAction:photo];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }];
    [alertController addAction:cancle];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
 
}

//UIImagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    [self.headBT setImage:info[UIImagePickerControllerEditedImage] forState:(UIControlStateNormal)];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//选男
-(void)manAction {
    [self.manButton setImage:[UIImage imageNamed:@"967"] forState:(UIControlStateNormal)];
    [self.womenButton setImage:[UIImage imageNamed:@"968"] forState:
     UIControlStateNormal];
    self.sexChange = 1;
    
}
//选女
-(void)womenAction {
    [self.womenButton setImage:[UIImage imageNamed:@"966"] forState:(UIControlStateNormal)];
    [self.manButton setImage:[UIImage imageNamed:@"969"] forState:
     UIControlStateNormal];
    self.sexChange = 2;
}

//选星座
-(void)selectConstellation {
    self.conTableView.hidden = NO;
    
}
//选兴趣
-(void)selectHobby {
    self.hobbyTableView.hidden = NO;
}


//提交信息
-(void)publishAction{
    
    if ([self.nameTF.text isEqualToString:@""] || self.sexChange == 0 || [self.ageTF.text isEqualToString:@""] || [self.countryTF.text isEqualToString:@""] || [self.cityTF.text isEqualToString:@""] || [self.hobbyLB.text isEqualToString:@""] || [self.constellationLB.text isEqualToString:@""] || [self.introTextView.text isEqualToString:@""]) {
        
        [self showAlert:@"请补充您的资料"];
        
    }else{
        
        NSData * imageData = UIImageJPEGRepresentation(self.headBT.imageView.image, 0.5);
        
        [[GXNetWorkManager shareInstance] upLoadImage:imageData path:@"/common/upload" success:^(NSMutableDictionary * dict) {
            if ([dict[@"code"] isEqualToString:@"0"]) {
                NSLog(@"上传头像成功");
                self.headImageString = dict[@"data"][@"url"];
//                NSLog(@"%@",self.headImageString);
                
                NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
                
                [dictory setValue:self.UID forKey:@"UID"];
                [dictory setValue:self.nameTF.text forKey:@"UNickName"];
                [dictory setValue:self.introTextView.text forKey:@"USignaTure"];
                
                if (self.sexChange == 2) {
                    [dictory setValue:@"00_011_2" forKey:@"USex"];
                }else {
                    [dictory setValue:@"00_011_1" forKey:@"USex"];
                }
                
                [dictory setValue:self.ageTF.text forKey:@"UAge"];
                [dictory setValue:self.constellationLB.text forKey:@"UConstellation"];
                [dictory setValue:self.headImageString forKey:@"UHeadPortrait"];
                [dictory setValue:[NSString stringWithFormat:@"%@-%@",self.countryTF.text, self.cityTF.text] forKey:@"UHome"];
                [dictory setValue:self.hobbyLB.text forKey:@"UHobby"];
                
//                NSLog(@"%@", dictory);
                
                [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/edit" success:^(NSMutableDictionary * dict1) {
                    
//                    NSLog(@"dict1%@", dict1);
                    
                    if ([dict1[@"code"] isEqualToString:@"0"]) {
                        
                        NSMutableDictionary * dictory1 = [NSMutableDictionary dictionary];
                        [dictory1 setValue:self.phone forKey:@"phone"];
                        
                        
                        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory1 path:@"/user/getuserinfo" success:^(NSMutableDictionary * dict2) {
                            
//                            NSLog(@"%@",dict2);
                            if ([dict2[@"code"] isEqualToString:@"0"]) {
                                self.citizenModel = [XPCitizen new];
                                [self.citizenModel setValuesForKeysWithDictionary:dict2[@"data"]];
                                
                                RootTabBarController * rootVC = [[RootTabBarController alloc] init];
                                rootVC.citizenModel = self.citizenModel;
                                [self.navigationController pushViewController:rootVC animated:YES];
                            }else{
                                NSLog(@"##获取用户数据出错");
                            }
                            
                        } failed:^{
                            [self showAlert:@"获取用户信息失败"];
                        }];
                        
                    }else {
                        NSLog(@"个人设置失败");
                    }
                    
                } failed:^{
                    NSLog(@"失败");
                }];
                
            }else {
                NSLog(@"上传头像失败");
            }
        } failed:^{
            NSLog(@"上传头像失败");
        }];
        
    }
    
}

//tableView  delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 1110) {
        return 14;
    }else{
        return 12;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 1110) {
        
        UITableViewCell * cell = [self.hobbyTableView dequeueReusableCellWithIdentifier:@"CELL_hobby" forIndexPath:indexPath];
        NSArray * array = @[@"旅游", @"爬山", @"阅读",@"电影", @"上网", @"舞蹈", @"音乐", @"绘画", @"运动",@"交友", @"睡觉", @"美食", @"购物", @"其他"];
        cell.textLabel.text = array[indexPath.section];
        return cell;
    }else{
        
        UITableViewCell * cell = [self.conTableView dequeueReusableCellWithIdentifier:@"CELL_constellation" forIndexPath:indexPath];
        NSArray * array = @[@"水瓶座", @"双鱼座", @"白羊座",@"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座",@"天蝎座", @"射手座", @"摩羯座", @"水瓶座"];
        cell.textLabel.text = array[indexPath.section];
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(15);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1110) {
        NSArray * array = @[@"旅游", @"爬山", @"阅读",@"电影", @"上网", @"舞蹈", @"音乐", @"绘画", @"运动",@"交友", @"睡觉", @"美食", @"购物", @"其他"];
        self.hobbyLB.text = array[indexPath.section];
        self.hobbyLB.textColor = [UIColor blackColor];

    }else{
        NSArray * array = @[@"水瓶座", @"双鱼座", @"白羊座",@"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座",@"天蝎座", @"射手座", @"摩羯座"];
        self.constellationLB.text = array[indexPath.section];
        self.constellationLB.textColor = [UIColor blackColor];
    }

}

//textView delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.introTextView.text = textView.text;
    //    self.placeholderLabel.text = @"";
    self.placeholderLabel.hidden = YES;
    
    CGRect frame = self.view.frame;
    frame.origin.y = -(216 + SIZE_SCALE_IPHONE6(30));
    self.view.frame = frame;
    
    return YES;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    
    return YES;
}

//回收键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    self.hobbyTableView.hidden = YES;
    self.conTableView.hidden = YES;
    
    
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
