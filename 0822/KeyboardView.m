//
//  KeyboardView.m
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import "KeyboardView.h"
#import "PasswordRect.h"
#import "KeyboardRect.h"

#define sWidth [UIScreen mainScreen].bounds.size.width
#define sHeight [UIScreen mainScreen].bounds.size.height
#define keyHeight sHeight*0.6
#define mHexColor(hex, alphaValue) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue]

@interface KeyboardView ()<GetpasswordDelegate>

{
    UIButton *_closeBtn;
    UILabel *_title;
    UIView *_pwdInput;
    UIButton *_forgetPwdBtn;
    KeyboardRect *_keyboardRect;
    PasswordRect *_pwdRect;
    UIView *_sepLine;
    NSString *_password;
}

@property (nonatomic, strong) UIView *keyboard;

@end

@implementation KeyboardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.keyboard];
    }
    return self;
}

- (UIView *)keyboard {
    if (!_keyboard) {
        _keyboard = [[UIView alloc] initWithFrame:CGRectMake(0, sHeight, sWidth, 0)];
        _keyboard.backgroundColor = [UIColor whiteColor];
        [self constructKeyboard];
    }
    return _keyboard;
}



//构建keyboard

- (void)constructKeyboard{
    
#pragma mark 关闭按钮
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
#pragma mark 标题
    _title               = [[UILabel alloc]init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.center        = CGPointMake(_keyboard.center.x, 20);
    _title.bounds        = CGRectMake(0, 0, 100, 30);
    _title.text          = @"输入密码";
#pragma mark 分割线
    _sepLine                 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, sWidth, 0.25)];
    _sepLine.backgroundColor = mHexColor(0xc0c0c0, .5);
#pragma mark 密码框
    _pwdRect = [[PasswordRect alloc]initWithFrame:CGRectMake(0, 70, sWidth, 70)];
#pragma mark 键盘
    _keyboardRect                     = [[KeyboardRect alloc]initWithFrame:CGRectMake(0, keyHeight - sHeight*0.35, sWidth, sHeight*0.35)];
    _keyboardRect.getpasswordDelegate = self;
#pragma mark 其他
    [_keyboard addSubview:_closeBtn];
    [_keyboard addSubview:_title];
    [_keyboard addSubview:_sepLine];
    [_keyboard addSubview:_pwdRect];
    [_keyboard addSubview:_keyboardRect];
    
}

- (void)closeKeyboard{
    [self clearPassword];
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [UIColor whiteColor];
        _keyboard.frame      = CGRectMake(0, sHeight, sWidth, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)callKeyboard{
    [self clearPassword];
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _keyboard.frame      = CGRectMake(0, sHeight-keyHeight, sWidth, keyHeight);
    }];
}

-(void)clearPassword{
    [_keyboardRect.pwdArray removeAllObjects];
    [_keyboardRect.getpasswordDelegate backPassword:_keyboardRect.pwdArray];
}


#pragma mark 代理

-(void)backPassword:(NSMutableArray *)_array{
    _pwd            = [NSMutableArray arrayWithArray:_array];
    _pwdRect.pwdArr = [NSMutableArray arrayWithArray:_array];
    [_pwdRect setNeedsDisplay];
    if (_pwd.count == 6) {
        _password = @"";
        for (int i = 0; i < _pwd.count; i++) {
            _password = [_password stringByAppendingString:_pwd[i]];
        }
        
        if (self.getPassword) {
            self.getPassword(_password);
            [self closeKeyboard];
        }
    }
}


@end
