//
//  UITextField+DatePickerModelDate.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/2.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "UITextField+DatePickerModelDate.h"
#import "Header.h"
@implementation UITextField (DatePickerModelDate)

// 1
+ (UIDatePicker *)sharedDatePicker1;
{
    static UIDatePicker *daterPicker1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daterPicker1 = [[UIDatePicker alloc] init];
        daterPicker1.frame = CGRectMake(0, 0, 0, SIZE_SCALE_IPHONE6(190));
        daterPicker1.datePickerMode = UIDatePickerModeDate;
        
//        NSDate * maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 365 * 24 * 3600];
        NSDate * minDate = [NSDate dateWithTimeIntervalSinceNow:-10 * 365 * 24 * 3600];
        NSDate * maxDate = [NSDate date];
//        NSDate * maxDate = self.sta;
        
        daterPicker1.minimumDate = minDate;
        daterPicker1.maximumDate = maxDate;
    });
    
    return daterPicker1;
    
}


// 2
- (void)datePickerValueChanged1:(UIDatePicker *)sender
{
    if (self.isFirstResponder)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        self.text = [formatter stringFromDate:sender.date];
    }
}
// 3
- (void)setDatePickerInputModelDate:(BOOL)datePickerInputModelDate{
    if (datePickerInputModelDate)
    {
        self.inputView = [UITextField sharedDatePicker1];
        [[UITextField sharedDatePicker1] addTarget:self action:@selector(datePickerValueChanged1:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        self.inputView = nil;
        [[UITextField sharedDatePicker1] removeTarget:self action:@selector(datePickerValueChanged1:) forControlEvents:UIControlEventValueChanged];
    }
}
// 4
- (BOOL)datePickerInputModelDate
{
    return [self.inputView isKindOfClass:[UIDatePicker class]];
}

@end
