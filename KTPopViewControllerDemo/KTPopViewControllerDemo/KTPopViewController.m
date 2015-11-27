//
//  KTPopViewController.m
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTPopViewController.h"
@interface KTPopViewController()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) float tableCellHeight;
@end


@implementation KTPopViewController

#pragma mark - public methods
- (instancetype)initWithLableName:(NSArray *)labelArray
                       ImageArray:(NSArray *)imageArray
                         Position:(KTPopViewPosition)position {
    self = [super initWithFrame:CGRectMake(0, 0, KT_UISCREEN_WIDTH, KT_UISCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addTappedGesture];
    }

    return self;
}

- (void)showView:(BOOL)needShow {
    if (needShow) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

#pragma mark - private methods
- (void)addTappedGesture {
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self
                                      action:@selector(backgroundTapped)];
    [self addGestureRecognizer:tapped];
}

- (CGRect *)gotTableViewFrame:(KTPopViewPosition)position {
    CGRect *tableRect;
    switch (position) {
        case KTPopViewTopLeft:
            
            break;
        case KTPopViewTopRight:
            
            break;
        case KTPopViewBottomLeft:
            
            break;
        case KTPopViewBottomRight:
            
            break;
        default:
            break;
    }
   return tableRect;
}

#pragma mark - event response
- (void)backgroundTapped {
    [self showView:NO];

}

#pragma mark - setter / getter

@end
