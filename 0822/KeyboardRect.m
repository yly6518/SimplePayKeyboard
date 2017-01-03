//
//  KeyboardRect.m
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import "KeyboardRect.h"
#import "KeyboardView.h"

#define sWidth [UIScreen mainScreen].bounds.size.width
#define sHeight [UIScreen mainScreen].bounds.size.height
#define keyHeight sHeight*0.6
#define mHexColor(hex, alphaValue) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue]

@interface KeyboardRect ()
{
    NSMutableArray *_buttonArray;
    CGFloat _buttonWidth;
    CGFloat _buttonHeight;
}

@end

@implementation KeyboardRect

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _pwdArray            = [[NSMutableArray alloc]init];
        _buttonWidth         = frame.size.width/3;
        _buttonHeight        = frame.size.height/4;
        [self createNumsButton];
    }
    return self;
}

-(void)createNumsButton{
    _buttonArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",
                                                    @"4",@"5",@"6",
                                                    @"7",@"8",@"9",
                                                    @"清除",@"0",@"后退"]];
    for (int i = 0 , n = 0; i < 4; i++) {
        for (int j = 0 ; j < 3; j++ , n++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_buttonWidth * j, _buttonHeight * i, _buttonWidth, _buttonHeight)];
            button.tag = n;
            [button setTitle:_buttonArray[n] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 0.25;
            [self addSubview:button];
        }
        
    }
    
}

-(void)buttonClick:(UIButton *)sender{
    if ((sender.tag >= 0 && sender.tag <= 8) || sender.tag == 10) {
        if (_pwdArray.count < 6) {
            [_pwdArray addObject:sender.titleLabel.text];
        }
    }else if (sender.tag == 9){
        [_pwdArray removeAllObjects];
    }else{
        [_pwdArray removeLastObject];
    }
    [self.getpasswordDelegate backPassword:_pwdArray];
}


@end
