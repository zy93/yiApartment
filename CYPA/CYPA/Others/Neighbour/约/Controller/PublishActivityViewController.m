//
//  PublishActivityViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PublishActivityViewController.h"
#import "Header.h"
@interface PublishActivityViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property(nonatomic,strong)UILabel * personLabel1;
@property(nonatomic, strong)UITextField * placeTF;
@property(nonatomic, strong)UITextField * activityNameTF;
@property(nonatomic, strong)UITextField * timeTF;

@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)UIImagePickerController * picker;

@property(nonatomic, strong)NSMutableArray * imvDataArray;

@property(nonatomic, strong)UITextView * introTextView;
@property(nonatomic, strong)UILabel *placeholderLabel;

@property(nonatomic, strong)UIButton * publishBT;

//上传图片的字符串
@property(nonatomic, strong)NSString * picID;
@property(nonatomic, strong)NSMutableString * picString;


@end

@implementation PublishActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];

}

-(void)setupViews {
    
    self.imvDataArray = [NSMutableArray array];
    
    //初始化可变字符串
    self.picID = [NSMutableString string];
    self.picString = [NSMutableString string];
    
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //信息view
    //发起人
    UIView * personView = [[UIView alloc] init];
    personView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:personView];
    
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * personLabel = [[UILabel alloc] init];
    personLabel.text = @"发起人";
    personLabel.font = [UIFont systemFontOfSize:15];
    [personView addSubview:personLabel];
    
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(personView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.personLabel1 = [[UILabel alloc] init];
    self.personLabel1.text = self.citizenModel.UNickName;
    self.personLabel1.font = [UIFont systemFontOfSize:15];
    [personView addSubview:self.personLabel1];
    
    [self.personLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(personView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(123));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //活动名称
    UIView * activityView = [[UIView alloc] init];
    activityView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:activityView];
    
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(personView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * activityLabel = [[UILabel alloc] init];
    activityLabel.text = @"活动名称";
    activityLabel.font = [UIFont systemFontOfSize:15];
    [activityView addSubview:activityLabel];
    
    [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(activityView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    self.activityNameTF = [[UITextField alloc] init];
    self.activityNameTF.font = [UIFont systemFontOfSize:15];
    self.activityNameTF.placeholder = @"填写";
    self.activityNameTF.layer.borderWidth = 0.5;
    [self.view addSubview:self.activityNameTF];
    
    [self.activityNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.left.mas_equalTo(self.personLabel1.mas_left);
        make.centerY.mas_equalTo(activityView.mas_centerY);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];

    //地点
    UIView * placeView = [[UIView alloc] init];
    placeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:placeView];
    
    [placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(activityView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * placeLabel = [[UILabel alloc] init];
    placeLabel.text = @"地点";
    placeLabel.font = [UIFont systemFontOfSize:15];
    [placeView addSubview:placeLabel];
    
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(placeView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.placeTF = [[UITextField alloc] init];
    self.placeTF.font = [UIFont systemFontOfSize:15];
    self.placeTF.placeholder = @"填写";
    self.placeTF.layer.borderWidth = 0.5;
    [self.view addSubview:self.placeTF];
    
    [self.placeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(placeView.mas_centerY);
        make.left.mas_equalTo(self.activityNameTF.mas_left);
        make.right.mas_equalTo(self.activityNameTF.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    //时间
    UIView * timeView = [[UIView alloc] init];
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(placeView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"时间";
    timeLabel.font = [UIFont systemFontOfSize:15];
    [timeView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.timeTF = [[UITextField alloc] init];
    self.timeTF.font = [UIFont systemFontOfSize:15];
    
    //时间选择
    self.timeTF.placeholder = @"请选择时间";
    self.timeTF.datePickerInput = YES;
    [timeView addSubview:self.timeTF];
    
    [self.timeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(timeView.mas_centerY);
        make.left.mas_equalTo(self.placeTF.mas_left);
        make.right.mas_equalTo(self.placeTF.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    //图片展示
    UIView * pictureView = [[UIView alloc] init];
    pictureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pictureView];
    
    [pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * pictureLabel = [[UILabel alloc] init];
    pictureLabel.text = @"图片";
    pictureLabel.font = [UIFont systemFontOfSize:15];
    [pictureView addSubview:pictureLabel];
    
    [pictureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(pictureView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];

    //图片列表
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44));
    layout.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_pic"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.activityNameTF.mas_left);
        make.right.mas_equalTo(self.activityNameTF.mas_right);
        make.centerY.mas_equalTo(pictureView.mas_centerY);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(44));
    }];
    
    
    //活动介绍
    UIView * introView = [[UIView alloc] init];
    introView.backgroundColor = [UIColor whiteColor];
    introView.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    introView.layer.masksToBounds = YES;
    [self.view addSubview:introView];
    
    [introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pictureView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel * introLabel = [[UILabel alloc] init];
    introLabel.text = @"活动介绍";
    introLabel.font = [UIFont systemFontOfSize:15];
    [introView addSubview:introLabel];
    
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introView.mas_top).offset(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.introTextView = [[UITextView alloc] init];
    self.introTextView.font = [UIFont systemFontOfSize:13];
    self.introTextView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.introTextView.delegate = self;
    [self.view addSubview:self.introTextView];
    
    [self.introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(50));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(70));
    }];
    
    
    //textview的placeholder
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
    self.placeholderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.text = @"  可以填写联系方式及活动简介，吸引你的小伙伴";
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.introTextView addSubview:self.placeholderLabel];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(275), SIZE_SCALE_IPHONE6(40)));
    }];
    
    //发布
    _publishBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _publishBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _publishBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _publishBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _publishBT.layer.masksToBounds = YES;
    [_publishBT setTitle:@"发起" forState:(UIControlStateNormal)];
    [self.view addSubview:_publishBT];
    [_publishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.introTextView.mas_bottom).offset(SIZE_SCALE_IPHONE6(30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(84), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_publishBT addTarget:self action:@selector(publishAction) forControlEvents:(UIControlEventTouchUpInside)];
  
}

-(void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//发布
-(void)publishAction {

    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.picID forKey:@"picID"];
    [dictory setValue:self.placeTF.text forKey:@"Area"];
    [dictory setValue:self.timeTF.text forKey:@"beginDate"];
    [dictory setValue:self.introTextView.text forKey:@"Intro"];
    [dictory setValue:self.citizenModel.UID
               forKey:@"UID"];
    [dictory setValue:self.activityNameTF.text forKey:@"Name"];

//    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/new" success:^(NSMutableDictionary * dict) {

//        NSLog(@"%@", self.picID);

        [self showAlertWithString:@"发布成功"];
        
    } failed:^{
        [self showAlertWithString:@"数据发布失败"];
    }];
    
//    NSLog(@"%@", self.picID);
    
//    [self.navigationController popToRootViewControllerAnimated:YES];

    sleep(1);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//collectionView  delegate  dateSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.imvDataArray.count == 9) {
        return self.imvDataArray.count;
    }else {
        return self.imvDataArray.count + 1;
    }
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_pic" forIndexPath:indexPath];
    
    //    cell.backgroundView = [[UIImageView alloc] initWithImage:self.imvDataArray[(self.imvDataArray.count - indexPath.row - 1)]];
    
    if (indexPath.row == self.imvDataArray.count) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"974"]];
    }else {
        cell.backgroundView = [[UIImageView alloc] initWithImage:self.imvDataArray[indexPath.row]];
    }
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger s = self.imvDataArray.count;
    if (indexPath.row == s) {
        [self addPictureAction];
    }
}


////选择多张照片
//- (void)pickImageWithType:(UIImagePickerControllerSourceType)type{
//    YBImagePickerViewController *picker = [[YBImagePickerViewController alloc]init];
//    picker.max_count = 9;
//    picker.delegate = self;
//    [self presentViewController:picker animated:YES completion:nil];
//}


//UIImagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self.imvDataArray addObject:info[UIImagePickerControllerEditedImage]];
    
    NSData * imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage], 0.5);
    
    [[GXNetWorkManager shareInstance] upLoadImage:imageData path:@"/common/upload" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@", dict);
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            [self.picString appendString:[NSString stringWithFormat:@";%@",dict[@"data"][@"url"]]];
            self.picID = [self.picString substringFromIndex:1];
            
//            NSLog(@"%@", self.picID);
            
            
        }else {
            NSLog(@"上传图片失败");
        }
        
    } failed:^{
        NSLog(@"数据上传失败");
        [self showAlertWithString:@"数据上传失败"];
    }];

    
    //    [self.imvDataArray
    //刷新collectionView
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
        
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
    
}


//添加照片
-(void)addPictureAction{
    
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
            
            
            //刷新collectionView
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                
            });
            
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
        
        
        //刷新collectionView
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            
        });
        
        
    }];
    [alertController addAction:photo];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }];
    [alertController addAction:cancle];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
