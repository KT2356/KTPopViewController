//
//  KTPopViewController.h
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KTPopViewMacro.h"

@interface KTPopViewController : UIView

typedef enum: NSInteger {
    KTPopViewTopLeft,
    KTPopViewTopRight,
    KTPopViewBottomLeft,
    KTPopViewBottomRight,
} KTPopViewPosition;

- (instancetype)initWithLableName:(NSArray *)labelArray
                       ImageArray:(NSArray *)imageArray
                         Position:(KTPopViewPosition)position;
- (void)showView:(BOOL)needShow;
@end
