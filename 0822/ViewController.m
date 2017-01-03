//
//  ViewController.m
//  0822
//
//  Created by Wang on 16/8/22.
//  Copyright © 2016年 Aira. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardView.h"

#define sWidth [UIScreen mainScreen].bounds.size.width
#define sHeight [UIScreen mainScreen].bounds.size.height
#define keyHeight sHeight*0.4


@interface ViewController ()

- (IBAction)callBtn:(UIButton *)sender;

@property (nonatomic, strong) KeyboardView *keyboardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyboardView = [[KeyboardView alloc]initWithFrame:self.view.frame];
    __weak __typeof(self) weakSelf = self;
    _keyboardView.getPassword = ^(NSString *password){
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:password message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
        [weakSelf presentViewController:ac animated:YES completion:nil];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)callBtn:(UIButton *)sender {
    [self.view addSubview:_keyboardView];
    [_keyboardView callKeyboard];
}





@end
