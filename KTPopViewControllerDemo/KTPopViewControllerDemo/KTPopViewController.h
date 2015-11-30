//
//  KTPopViewController.h
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KTPopViewMacro.h"

@protocol KTPopViewDelegate<NSObject>
@required
- (void)KTPopViewDidSelectedTableRow:(NSInteger)row;
@end


@interface KTPopViewController : UIView
@property (nonatomic,weak) id <KTPopViewDelegate> delegate;

//Public methods
- (instancetype)initWithLableName:(NSArray *)labelArray
                       ImageArray:(NSArray *)imageArray
                         Position:(KTPopViewPosition)position;
- (void)showView:(BOOL)needShow;
@end
