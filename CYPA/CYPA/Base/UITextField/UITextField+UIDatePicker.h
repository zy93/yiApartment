//
//  UITextField+UIDatePicker.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/29.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (UIDatePicker)
@property (nonatomic, assign) BOOL datePickerInput;

+ (UIDatePicker *)sharedDatePicker;

@end
