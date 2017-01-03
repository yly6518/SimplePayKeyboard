//
//  passwordRect.m
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import "PasswordRect.h"
#import "KeyboardRect.h"
#import <math.h>

#define sWidth [UIScreen mainScreen].bounds.size.width
#define sHeight [UIScreen mainScreen].bounds.size.height
#define keyHeight sHeight*0.6
#define mHexColor(hex, alphaValue) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue]


@interface PasswordRect ()

@end

@implementation PasswordRect

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    /**
     *  rectWidth 密码框宽度
     *  rectHeight 密码框高度
     *  leftTopPointX 左上角点x坐标
     */
    CGFloat rectWidth     = sWidth - 80;
    CGFloat rectHeight    = rectWidth/6;
    CGFloat leftTopPointX = self.center.x - rectWidth/2;
    //密码边框线
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect pwdRect        = CGRectMake(leftTopPointX, 0, rectWidth, rectHeight);
    CGPathAddRoundedRect(path, NULL, pwdRect, 6, 6);
    CGContextRef ref      = UIGraphicsGetCurrentContext();
    CGContextAddPath(ref, path);
    [[UIColor grayColor] setStroke];
    CGContextSetLineWidth(ref,0.25);
    CGContextDrawPath(ref, kCGPathStroke);
    //密码分割竖线
    for (int i = 0; i < 5; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context,kCGLineCapSquare);
        CGContextSetLineWidth(context,.25);
        CGContextSetRGBStrokeColor(context,0, 0, 0, 0.4);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, leftTopPointX+((i+1)*rectWidth/6), 1);
        CGContextAddLineToPoint(context, leftTopPointX+((i+1)*rectWidth/6), rectHeight-1);
        CGContextStrokePath(context);
    }
    //画密码点
    /**
     *  space 点与边框的间距
     *  dotsize 点尺寸
     *  point 点左上角坐标
     */
    CGFloat space  = 25;
    CGSize dotSize = CGSizeMake(rectHeight - space, rectHeight - space);
    CGPoint point  = CGPointMake(leftTopPointX + space/2, space/2);
    if (_pwdArr.count > 0) {
        for (int i = 0; i < _pwdArr.count; i++) {
            UIImage *dot = [UIImage imageNamed:@"black_Dot"];
            [dot drawInRect:CGRectMake(point.x+i*rectWidth/6, point.y, dotSize.width, dotSize.height)];
        }
    }
    
}


@end
