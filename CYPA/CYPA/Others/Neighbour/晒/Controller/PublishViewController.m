//
//  PublishViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/8.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PublishViewController.h"
#import "Header.h"

@interface PublishViewController ()<UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UITextView * inputView;
@property(nonatomic, strong)UIButton * publishBT;
@property(nonatomic, strong)UILabel * placeholderLabel;
@property(nonatomic, strong)UIImagePickerController * picker;
@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)NSMutableArray *imvDataArray;
@property(nonatomic, strong)UIButton * addBT;

//上传图片的字符串
@property(nonatomic, strong)NSString * showPic;
@property(nonatomic, strong)NSMutableString * picString;

@end

@implementation PublishViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化可变字符串
    self.showPic = [NSMutableString string];
    self.picString = [NSMutableString string];

    [self setupViews];

    self.view.backgroundColor = [UIColor grayColor];
    
}
-(void)setupViews {
    
    self.imvDataArray = [NSMutableArray array];
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(275));
    }];
    
    UIButton * cancleBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancleBT setImage:[UIImage imageNamed:@"973"] forState:(UIControlStateNormal)];
    [self.view addSubview:cancleBT];
    
    [cancleBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_right);
        make.centerY.mas_equalTo(view.mas_top);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(17), SIZE_SCALE_IPHONE6(17)));
    }];
    
    [cancleBT addTarget:self action:@selector(cancleAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //头像
    self.headImv = [[UIImageView alloc] init];
    self.headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(15);
//    self.headImv.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.citizenModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    self.headImv.layer.masksToBounds = YES;
    [self.view addSubview:self.headImv];
    
    [self.headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(SIZE_SCALE_IPHONE6(8));
        make.left.mas_equalTo(view.mas_left).offset(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(30), SIZE_SCALE_IPHONE6(30)));
    }];
    
    //姓名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = self.citizenModel.UNickName;
//    self.nameLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImv.mas_centerY);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //性别
    self.genderImv = [[UIImageView alloc] init];
//    self.genderImv.backgroundColor = [UIColor cyanColor];
    if ([self.citizenModel.USex isEqualToString: @"00_011_2"]) {
        self.genderImv.image = [UIImage imageNamed:@"964"];
    }else{
        self.genderImv.image = [UIImage imageNamed:@"963"];
    }
    [self.view addSubview:self.genderImv];
    
    [self.genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    //图片列表
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(56), SIZE_SCALE_IPHONE6(54));
    layout.minimumLineSpacing = SIZE_SCALE_IPHONE6(10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(20);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_pic"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(SIZE_SCALE_IPHONE6(35));
        make.bottom.mas_equalTo(view.mas_bottom).offset(SIZE_SCALE_IPHONE6(-75));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(56));
        make.right.mas_equalTo(view.mas_right).offset(SIZE_SCALE_IPHONE6(-35));
    }];

    //输入框
    self.inputView = [[UITextView alloc] init];
//    self.inputView.backgroundColor = [UIColor yellowColor];
    self.inputView.delegate = self;
    self.inputView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.inputView];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(view.mas_left).offset(SIZE_SCALE_IPHONE6(30));
        make.right.mas_equalTo(view.mas_right).offset(SIZE_SCALE_IPHONE6(-30));
        make.bottom.mas_equalTo(_collectionView.mas_top).offset(SIZE_SCALE_IPHONE6(-5));
        
    }];
    
    //发布
    _publishBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _publishBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _publishBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _publishBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _publishBT.layer.masksToBounds = YES;
    [_publishBT setTitle:@"发布" forState:(UIControlStateNormal)];
    [self.view addSubview:_publishBT];
    [_publishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom).offset(SIZE_SCALE_IPHONE6(-27.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(84), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_publishBT addTarget:self action:@selector(publishAction) forControlEvents:(UIControlEventTouchUpInside)];

    //textview的placeholder
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
    self.placeholderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.text = @"  还可以输入300个字...";
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.inputView addSubview:self.placeholderLabel];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(315), SIZE_SCALE_IPHONE6(40)));
    }];
    
    
}

-(void)cancleAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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

//发布晒
-(void)publishAction {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.showPic forKey:@"ShowPic"];
    
    NSString * contentString = [NSString stringWithFormat:@"%@", self.inputView.text];
    
//    NSString *contentString = [self.inputView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [dictory setValue:contentString forKey:@"ShowCont"];
    [dictory setValue:self.citizenModel.UID forKey:@"UID"];
    
//    NSLog(@"%@", dictory[@"ShowCont"]);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/show" success:^(NSMutableDictionary * dict) {
    
        if ([dict[@"code"] isEqualToString:@"0"]) {
            sleep(1);
            [self dismissViewControllerAnimated:YES completion:nil];
            [self showAlertWithString:@"发布成功"];

        }else{
//            [self showAlertWithString:@"暂时不支持表情哎..."];
            NSLog(@"暂时不支持表情哎...");
            [MBProgressHUD showSuccess:@"暂时不支持表情哎..."];
            
        }
        
    } failed:^{
        [self showAlertWithString:@"数据发布失败"];
    }];




}

//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

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
            self.showPic = [self.picString substringFromIndex:1];
            
//            NSLog(@"%@", self.showPic);
            
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
    self.inputView.text = textView.text;
    self.placeholderLabel.hidden = YES;
    return YES;
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
