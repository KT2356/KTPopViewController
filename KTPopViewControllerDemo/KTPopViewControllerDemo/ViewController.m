//
//  ViewController.m
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTPopViewController.h"

@interface ViewController ()
- (IBAction)popAction:(UIBarButtonItem *)sender;
@property (nonatomic, strong) KTPopViewController *ktPopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)popAction:(UIBarButtonItem *)sender {
    [self.view addSubview:self.ktPopView];
}

- (KTPopViewController *)ktPopView {
    if (!_ktPopView) {
        _ktPopView  = [[KTPopViewController alloc] initWithLableName:@[@"啦啦啦啊",@"去玩儿的",@"对方的身",@"扣扣风格"] ImageArray:@[@"item_battle",@"item_chat",@"item_school",@"item_share"] Position:KTPopViewTopLeft];
    }
    [_ktPopView showView:YES];
    return _ktPopView;
}

@end
