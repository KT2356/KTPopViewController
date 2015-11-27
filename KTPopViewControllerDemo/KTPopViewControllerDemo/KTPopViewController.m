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
        [self addTappedGesture];
        self.nameArray = labelArray;
        self.imageArray = imageArray;
        self.tableCellHeight = 45;
        
        [self setTableViewWithPosition:position];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTPopViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.nameArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
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
