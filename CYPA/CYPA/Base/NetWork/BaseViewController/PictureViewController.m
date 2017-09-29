//
//  PictureViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/4/1.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PictureViewController.h"
#import "Header.h"
@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupViews];

}

-(void)setupViews{
    
    UIImageView * pictureImv = [[UIImageView alloc] init];
    pictureImv.frame = CGRectMake(0, 0.5*SIZE_SCALE_IPHONE6(667)-SIZE_SCALE_IPHONE6(188), SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(375));
    [pictureImv sd_setImageWithURL:[NSURL URLWithString:self.aString] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [self.view addSubview:pictureImv];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
