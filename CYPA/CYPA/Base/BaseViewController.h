//
//  BaseViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/19.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//提示框
//-(void)showAlertWithString:(NSString *)aString;

- (void)showAlert:(NSString *) aString;
- (void)showAlertWithString:(NSString *) _message;
- (void)showAlertAndBackWithString:(NSString *) _message;
//-(void)afn;
-(void)checkNetWork;
@end
