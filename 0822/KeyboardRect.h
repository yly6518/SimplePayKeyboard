//
//  KeyboardRect.h
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardView.h"

@protocol GetpasswordDelegate <NSObject>

-(void)backPassword:(NSMutableArray *)_array;

-(void)closeKeyboard;

@end


@interface KeyboardRect : UIView

@property (nonatomic, strong) NSMutableArray *pwdArray;

@property (nonatomic, copy) NSMutableArray *(^callback)();

@property (nonatomic, assign) id<GetpasswordDelegate> getpasswordDelegate;


@end
