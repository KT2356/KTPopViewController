//
//  KTPopViewController.m
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTPopViewController.h"
@interface KTPopViewController()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) float tableCellHeight;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger position;
@end

@implementation KTPopViewController

#pragma mark - public methods
- (instancetype)initWithLableName:(NSArray *)labelArray
                       ImageArray:(NSArray *)imageArray
                         Position:(KTPopViewPosition)position {
    _position = position;
    self = [super initWithFrame:CGRectMake(0, 0, KT_UISCREEN_WIDTH, KT_UISCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.nameArray       = labelArray;
        self.imageArray      = imageArray;
        self.tableCellHeight = 40;
        [self setTableViewWithPosition:position];
        [self addTappedGesture];
        self.hidden = YES;
    }
    return self;
}

- (void)showView:(BOOL)needShow {
    if (needShow && self.hidden == NO) {
        [self showView:NO];
        return;
    }
    if (needShow) {
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform transform ;
            if (_position == KTPopViewTopLeft || _position == KTPopViewTopRight) {
                transform = CGAffineTransformMakeTranslation(0,_tableView.bounds.size.height+10);
            } else if (_position == KTPopViewBottomLeft) {
                transform = CGAffineTransformMakeTranslation(145,0);
            } else if (_position == KTPopViewBottomRight) {
                transform = CGAffineTransformMakeTranslation(-145,0);
            }
            self.transform = transform;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0,0);
            self.transform = transform;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}


#pragma mark - private methods
- (void)addTappedGesture {
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self
                                      action:@selector(backgroundTapped)];
    tapped.delegate = self;
    [self addGestureRecognizer:tapped];
}

- (void)drawRect:(CGRect)rect {
    CGPoint startPoint;
    CGPoint secontPoint;
    CGPoint thirdPoint;
    switch (_position) {
        case KTPopViewTopLeft:
            startPoint  = CGPointMake(23.5, 3);
            secontPoint = CGPointMake(19, 10);
            thirdPoint  = CGPointMake(28, 10);
            break;
        case KTPopViewTopRight:
            startPoint  = CGPointMake(KT_UISCREEN_WIDTH - 23.5, 3);
            secontPoint = CGPointMake(KT_UISCREEN_WIDTH -19, 10);
            thirdPoint  = CGPointMake(KT_UISCREEN_WIDTH -28, 10);
            break;
        case KTPopViewBottomLeft:
            startPoint  = CGPointMake(23.5, KT_UISCREEN_HEIGHT -64 -44-3);
            secontPoint = CGPointMake(19, KT_UISCREEN_HEIGHT -64 -44-10);
            thirdPoint  = CGPointMake(28, KT_UISCREEN_HEIGHT -64 -44-10);
            break;
        case KTPopViewBottomRight:
            startPoint  = CGPointMake(KT_UISCREEN_WIDTH +145 -23.5, KT_UISCREEN_HEIGHT -64 -44-3);
            secontPoint = CGPointMake(KT_UISCREEN_WIDTH +145 -19, KT_UISCREEN_HEIGHT -64 -44-10);
            thirdPoint  = CGPointMake(KT_UISCREEN_WIDTH +145 -28, KT_UISCREEN_HEIGHT -64 -44-10);
            break;
        default:
            break;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, secontPoint.x, secontPoint.y);
    CGContextAddLineToPoint(context, thirdPoint.x, thirdPoint.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.2 alpha:1].CGColor);
    CGContextDrawPath(context, kCGPathFill);
}


- (CGRect)gotTableViewFrame:(KTPopViewPosition)position {
    CGRect tableRect;
    switch (position) {
        case KTPopViewTopLeft:
            tableRect = CGRectMake(10, 10, 125, self.nameArray.count * self.tableCellHeight);
            break;
        case KTPopViewTopRight:
            tableRect = CGRectMake(KT_UISCREEN_WIDTH-125-10, 10, 125, self.nameArray.count * self.tableCellHeight);
            break;
        case KTPopViewBottomLeft:
            tableRect = CGRectMake(10, KT_UISCREEN_HEIGHT - 64-44 -10 - self.nameArray.count * self.tableCellHeight, 125, self.nameArray.count * self.tableCellHeight);
            break;
        case KTPopViewBottomRight:
            tableRect = CGRectMake(KT_UISCREEN_WIDTH +145 -10 -125, KT_UISCREEN_HEIGHT - 64 - 44 -10 - self.nameArray.count * self.tableCellHeight, 125, self.nameArray.count * self.tableCellHeight);
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

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showView:NO];
    if ([self.delegate respondsToSelector:@selector(KTPopViewDidSelectedTableRow:)]) {
        [self.delegate KTPopViewDidSelectedTableRow:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTPopViewCell"];
    cell.backgroundColor        = [UIColor clearColor];
    cell.imageView.image        = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text         = self.nameArray[indexPath.row];
    cell.textLabel.font         = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor    = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    return cell;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark - setter / getter
- (void)setTableViewWithPosition:(KTPopViewPosition)position {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self gotTableViewFrame:position]];
        _tableView.delegate           = self;
        _tableView.dataSource         = self;
        _tableView.backgroundColor    = [UIColor colorWithWhite:0.2 alpha:1];
        _tableView.layer.cornerRadius = 2;
        _tableView.scrollEnabled      = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"KTPopViewCell"];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 15)];
        _tableView.separatorColor  = [UIColor colorWithWhite:0.3 alpha:1];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 1)];
        [self addSubview:_tableView];
    }
    
    if (_position == KTPopViewBottomLeft) {
        self.frame = CGRectMake(-145, 0, KT_UISCREEN_WIDTH +145, KT_UISCREEN_HEIGHT);
    } else if (_position == KTPopViewBottomRight) {
        self.frame = CGRectMake(0, 0, KT_UISCREEN_WIDTH +145, KT_UISCREEN_HEIGHT);
    } else {
        self.frame = CGRectMake(0, -_tableView.bounds.size.height-10, KT_UISCREEN_WIDTH, KT_UISCREEN_HEIGHT+_tableView.bounds.size.height+10);
    }
}
- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [[NSArray alloc] init];
    }
    return _nameArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSArray alloc] init];
    }
    return _imageArray;
}

@end
