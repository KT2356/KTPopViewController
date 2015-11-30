//
//  ViewController.m
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTPopViewController.h"

@interface ViewController ()<KTPopViewDelegate>
- (IBAction)popAction:(UIBarButtonItem *)sender;
- (IBAction)topRight:(UIBarButtonItem *)sender;
- (IBAction)bottomLeft:(UIBarButtonItem *)sender;
- (IBAction)bottomRight:(UIBarButtonItem *)sender;
@property (nonatomic, strong) KTPopViewController *ktPopView;
@property (nonatomic, strong) KTPopViewController *ktPopViewTopRight;
@property (nonatomic, strong) KTPopViewController *ktPopViewBottomLeft;
@property (nonatomic, strong) KTPopViewController *ktPopViewBottomRight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)popAction:(UIBarButtonItem *)sender {
    [self.view addSubview:self.ktPopView];
}

- (IBAction)topRight:(UIBarButtonItem *)sender {
    [self.view addSubview:self.ktPopViewTopRight];
}

- (IBAction)bottomLeft:(UIBarButtonItem *)sender {
    [self.view addSubview:self.ktPopViewBottomLeft];
}

- (IBAction)bottomRight:(UIBarButtonItem *)sender {
    [self.view addSubview:self.ktPopViewBottomRight];
}

#pragma mark - KTPopViewDelegate
- (void)KTPopViewDidSelectedTableRow:(NSInteger)row {
    NSLog(@"%ld",(long)row);
}


#pragma mark - setter/getter
- (KTPopViewController *)ktPopView {
    if (!_ktPopView) {
        _ktPopView  = [[KTPopViewController alloc] initWithLableName:@[@"啦啦啦啊",@"去玩儿的",@"对方的身",@"扣扣风格"] ImageArray:@[@"item_battle",@"item_chat",@"item_school",@"item_share"] Position:KTPopViewTopLeft];
            _ktPopView.delegate = self;
    }
    [_ktPopView showView:YES];
    return _ktPopView;
}

- (KTPopViewController *)ktPopViewTopRight {
    if (!_ktPopViewTopRight) {
        _ktPopViewTopRight  = [[KTPopViewController alloc] initWithLableName:@[@"啦啦11",@"啦啦11",@"去玩儿的",@"对方的身",@"扣扣风格"] ImageArray:@[@"item_battle",@"item_chat",@"item_chat",@"item_school",@"item_share"] Position:KTPopViewTopRight];
        _ktPopViewTopRight.delegate = self;
    }
    [_ktPopViewTopRight showView:YES];
    return _ktPopViewTopRight;
}

- (KTPopViewController *)ktPopViewBottomLeft {
    if (!_ktPopViewBottomLeft) {
        _ktPopViewBottomLeft  = [[KTPopViewController alloc] initWithLableName:@[@"啦啦11",@"啦啦11"] ImageArray:@[@"item_battle",@"item_chat"] Position:KTPopViewBottomLeft];
        _ktPopViewBottomLeft.delegate = self;
    }
    [_ktPopViewBottomLeft showView:YES];
    return _ktPopViewBottomLeft;
}
- (KTPopViewController *)ktPopViewBottomRight {
    if (!_ktPopViewBottomRight) {
        _ktPopViewBottomRight  = [[KTPopViewController alloc] initWithLableName:@[@"去玩儿的"] ImageArray:@[@"item_share"] Position:KTPopViewBottomRight];
        _ktPopViewBottomRight.delegate = self;
    }
    [_ktPopViewBottomRight showView:YES];
    return _ktPopViewBottomRight;
}
@end
