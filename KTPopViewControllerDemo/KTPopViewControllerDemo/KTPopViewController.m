//
//  KTPopViewController.m
//  KTPopViewControllerDemo
//
//  Created by KT on 15/11/27.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTPopViewController.h"
@interface KTPopViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) float tableCellHeight;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *imageArray;
@end


@implementation KTPopViewController

#pragma mark - public methods
- (instancetype)initWithLableName:(NSArray *)labelArray
                       ImageArray:(NSArray *)imageArray
                         Position:(KTPopViewPosition)position {
    self = [super initWithFrame:CGRectMake(0, 0, KT_UISCREEN_WIDTH, KT_UISCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.nameArray = labelArray;
        self.imageArray = imageArray;
        self.tableCellHeight = 40;
        [self setTableViewWithPosition:position];
        self.frame = CGRectMake(0, -_tableView.bounds.size.height-10, KT_UISCREEN_WIDTH, KT_UISCREEN_HEIGHT+_tableView.bounds.size.height+10);
        [self addTappedGesture];
        
        UIView *newview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        newview.backgroundColor = [UIColor greenColor];
        [self addSubview:newview];
    }

    return self;
}

- (void)showView:(BOOL)needShow {
    if (needShow) {
        self.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0,_tableView.bounds.size.height+10);
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
    [self addGestureRecognizer:tapped];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 23, 3);
    CGContextAddLineToPoint(context, 18.5, 10);
    CGContextAddLineToPoint(context, 27.5, 10);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.2 alpha:1].CGColor);
    CGContextDrawPath(context, kCGPathFill);
}


- (CGRect)gotTableViewFrame:(KTPopViewPosition)position {
    CGRect tableRect;
    switch (position) {
        case KTPopViewTopLeft:
            tableRect = CGRectMake(10, 10, 125, self.nameArray.count * self.tableCellHeight + 1);
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

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(KTPopViewDidSelected:)]) {
        [self.delegate KTPopViewDidSelected:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTPopViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.nameArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - setter / getter
- (void)setTableViewWithPosition:(KTPopViewPosition)position {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self gotTableViewFrame:position]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        _tableView.layer.cornerRadius = 2;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"KTPopViewCell"];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 15)];
        _tableView.separatorColor = [UIColor colorWithWhite:0.3 alpha:1];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 1)];
        [self addSubview:_tableView];
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
