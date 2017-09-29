//
//  UITextField+UIDataPicker1.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "UITextField+UIDataPicker1.h"

@implementation UITextField (UIDataPicker1)

// 1
+ (UIDatePicker *)sharedDatePicker11;
{
    static UIDatePicker *daterPicker11 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daterPicker11 = [[UIDatePicker alloc] init];
        daterPicker11.datePickerMode = UIDatePickerModeDate;
        
        NSDate * maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 365 * 24 * 3600];
        NSDate * minDate = [NSDate date];
        //        NSDate * maxDate = [NSDate date];
        
        daterPicker11.minimumDate = minDate;
        daterPicker11.maximumDate = maxDate;
        
    });
    
    return daterPicker11;
    
}


// 2
- (void)datePickerValueChanged11:(UIDatePicker *)sender
{
    if (self.isFirstResponder)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        self.text = [formatter stringFromDate:sender.date];
    }
}
// 3
- (void)setDatePickerInput11:(BOOL)datePickerInput11
{
    if (datePickerInput11)
    {
        self.inputView = [UITextField sharedDatePicker11];
        [[UITextField sharedDatePicker11] addTarget:self action:@selector(datePickerValueChanged11:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        self.inputView = nil;
        [[UITextField sharedDatePicker11] removeTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}
// 4
- (BOOL)datePickerInput
{
    return [self.inputView isKindOfClass:[UIDatePicker class]];
}


@end
