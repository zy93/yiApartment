//
//  UITextField+UIDatePicker.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/29.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "UITextField+UIDatePicker.h"

@implementation UITextField (UIDatePicker)
// 1
+ (UIDatePicker *)sharedDatePicker;
{
    static UIDatePicker *daterPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daterPicker = [[UIDatePicker alloc] init];
        daterPicker.datePickerMode = UIDatePickerModeDateAndTime;
        
        NSDate * maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 365 * 24 * 3600];
        NSDate * minDate = [NSDate date];
//        NSDate * maxDate = [NSDate date];
        
        daterPicker.minimumDate = minDate;
        daterPicker.maximumDate = maxDate;
        
    });
    
    return daterPicker;
    
}


// 2
- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    if (self.isFirstResponder)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH"];
        self.text = [formatter stringFromDate:sender.date];
    }
}
// 3
- (void)setDatePickerInput:(BOOL)datePickerInput
{
    if (datePickerInput)
    {
        self.inputView = [UITextField sharedDatePicker];
        [[UITextField sharedDatePicker] addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        self.inputView = nil;
        [[UITextField sharedDatePicker] removeTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}
// 4
- (BOOL)datePickerInput
{
    return [self.inputView isKindOfClass:[UIDatePicker class]];
}


@end
