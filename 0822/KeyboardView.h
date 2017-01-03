//
//  KeyboardView.h
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KeyboardView : UIView

@property (nonatomic, strong) NSMutableArray *pwd;

-(void)callKeyboard;

-(void)closeKeyboard;

@property (nonatomic, copy) void (^getPassword)(NSString *password);

@end
