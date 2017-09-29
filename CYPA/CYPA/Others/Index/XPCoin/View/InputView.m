//
//  InputView.m
//  PasswordDemo
//
//  Created by yaoxiaobing on 16/1/23.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "InputView.h"
#import "Masonry.h"
#import "PasswordView.h"
#import "Header.h"
@interface InputView ()
@property (nonatomic, strong) PasswordView *passwordView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation InputView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.passwordView];
        [self addSubview:self.tipLabel];
    
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(self).offset(SIZE_SCALE_IPHONE6(80));
            make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
            make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        }];
        
        
        [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(264, 44));
            make.top.equalTo(self.tipLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(50));
            make.centerX.equalTo(self);
        }];
    }
    return self;

}


- (void)clear
{
    [self.passwordView cleanLastState];
}


#pragma mark - FirstResponder
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return  [self.passwordView becomeFirstResponder];
    
}

- (void)setTip:(NSString *)tip
{
    _tip = tip;
    self.tipLabel.font = [UIFont systemFontOfSize:15];
    self.tipLabel.text = tip;
}

- (void)setTextChangeBlock:(void (^)(NSString *))textChangeBlock
{
    _textChangeBlock = textChangeBlock;
    self.passwordView.textChangedBlock = textChangeBlock;

}

#pragma mark - getter
- (PasswordView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PasswordView class]) owner:nil options:nil].lastObject;
    }
    return _passwordView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
    }
    return _tipLabel;
}

@end
