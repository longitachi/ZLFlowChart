//
//  ZLFlowChart.m
//  ZLFlowChart
//
//  Created by long on 15/12/21.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLFlowChart.h"
#import "ZLFlowChartCell.h"
#import "ZLFlowChartCell2.h"
#import "ZLSpaceArrowCell.h"

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kViewWidth  [UIScreen mainScreen].bounds.size.width
#define kViewHeight [UIScreen mainScreen].bounds.size.height

#define kAnimationDuration 0.3

@interface ZLFlowChart () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, assign) NSInteger selIndex;

@end

@implementation ZLFlowChart
- (void)dealloc
{
    NSLog(@"");
}
- (instancetype)init
{
    return [self initWithTitle:nil stepArray:@[] showAnimationType:ZLFlowChartAnimationNone hideAnimationType:ZLFlowChartAnimationNone];
}

- (instancetype)initWithTitle:(NSString *)title stepArray:(NSArray<NSString *> *)stepArray
{
    return [self initWithTitle:title stepArray:stepArray showAnimationType:ZLFlowChartAnimationNone hideAnimationType:ZLFlowChartAnimationNone];
}

- (instancetype)initWithTitle:(NSString *)title stepArray:(NSArray<NSString *> *)stepArray showAnimationType:(ZLFlowChartAnimationType)showAnimationType hideAnimationType:(ZLFlowChartAnimationType)hideAnimationType
{
    if (self = [super init]) {
        self.mode = ZLFlowChartDefault;
        self.title = title;
        self.stepArray = stepArray;
        self.showAnimationType = showAnimationType;
        self.hideAnimationType = hideAnimationType;
        self.selIndex = -1;
        self.nowStepIndex = -1;
        self.normalColor = [UIColor blackColor];
        self.lineColor = [UIColor darkGrayColor];
        self.highlightedColor = [UIColor orangeColor];
        [self creatFlowChart];
    }
    return self;
}

#pragma mark - 初始化显示UI
- (void)creatFlowChart
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.alpha = 0;
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
    [self sendSubviewToBack:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth-40, (kViewWidth-40)*1.25) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.center = self.center;
    _tableView.layer.masksToBounds = YES;
    _tableView.layer.cornerRadius = 5.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self setFlowChartTitle];
    [self addSubview:_tableView];
}

- (void)tapAction
{
    [self hide];
}

- (void)setFlowChartTitle
{
    _tableView.tableHeaderView = nil;
    if (self.title.length > 0) {
        _tableView.tableHeaderView = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kViewWidth-40, 30)];
            lable.backgroundColor = RGB(240, 240, 240);
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = self.title;
            lable;
        });
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setFlowChartTitle];
}

#pragma mark - 显示/隐藏
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [_tableView reloadData];
    
    //滚动到当前选中下标
    if (self.nowStepIndex != -1 && self.nowStepIndex < self.stepArray.count) {
        if (self.mode == ZLFlowChartList) {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.nowStepIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        } else {
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.nowStepIndex/3*2 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
    }
    
    if (self.showAnimationType == 0 || self.showAnimationType & ZLFlowChartAnimationNone) {
        self.alpha = 1;
        return;
    }
    
    NSAssert(!((self.showAnimationType & ZLFlowChartAnimationZoomIn)&&(self.showAnimationType & ZLFlowChartAnimationZoomOut)), @"Animation type zoomIn and zoomOut can't coexist");
    
    NSMutableArray<CAAnimation *> *arrayAnimation = [NSMutableArray array];
    if (self.showAnimationType & ZLFlowChartAnimationRotation) {
        [arrayAnimation addObject:[self getRotaionAnimation]];
    }
    if (self.showAnimationType & ZLFlowChartAnimationZoomIn) {
        [arrayAnimation addObject:[self getZoomInAnimationIsShow:YES]];
    } else if (self.showAnimationType & ZLFlowChartAnimationZoomOut) {
        [arrayAnimation addObject:[self getZoomOutAnimationIsShow:YES]];
    }
    
    [_tableView.layer addAnimation:[self getAnimationGroupWithAnimations:arrayAnimation] forKey:nil];
    if (self.showAnimationType & ZLFlowChartAnimationFade) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.alpha = 1;
        }];
    } else {
        self.alpha = 1;
    }
}

- (void)showWithSelectStepIndex:(NSInteger)selIndex
{
    self.nowStepIndex = selIndex;
    [self show];
}

- (void)hide
{
    if (self.hideAnimationType == 0 || self.hideAnimationType & ZLFlowChartAnimationNone) {
        [self done];
    } else {
        NSAssert(!((self.hideAnimationType & ZLFlowChartAnimationZoomIn)&&(self.hideAnimationType & ZLFlowChartAnimationZoomOut)), @"Animation type zoomIn and zoomOut can't coexist");
        
        NSMutableArray<CAAnimation *> *arrayAnimation = [NSMutableArray array];
        if (self.hideAnimationType & ZLFlowChartAnimationRotation) {
            [arrayAnimation addObject:[self getRotaionAnimation]];
        }
        if (self.hideAnimationType & ZLFlowChartAnimationZoomIn) {
            [arrayAnimation addObject:[self getZoomInAnimationIsShow:NO]];
        } else if (self.hideAnimationType & ZLFlowChartAnimationZoomOut) {
            [arrayAnimation addObject:[self getZoomOutAnimationIsShow:NO]];
        }
        
        CAAnimationGroup *group = [self getAnimationGroupWithAnimations:arrayAnimation];
        group.delegate = self;
        [_tableView.layer addAnimation:group forKey:nil];
        if (self.hideAnimationType & ZLFlowChartAnimationFade) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.alpha = 0;
            }];
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self done];
}

- (void)done
{
    self.alpha = 0;
    [self removeFromSuperview];
    
    if (self.handler && self.selIndex != -1) {
        self.handler(self.selIndex, self.stepArray[self.selIndex]);
        self.selIndex = -1;
    }
}

#pragma mark - Animations
- (CAAnimationGroup *)getAnimationGroupWithAnimations:(NSArray<CAAnimation *> *)animations
{
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = animations;
    group.duration = kAnimationDuration;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

- (CAAnimation *)getRotaionAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(2*M_PI);
    
    return rotationAnimation;
}

- (CAAnimation *)getZoomInAnimationIsShow:(BOOL)isShow
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (isShow) {
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(1);
    } else {
        scaleAnimation.fromValue = @(1.0);
        scaleAnimation.toValue = @(0);
    }
    
    return scaleAnimation;
}

- (CAAnimation *)getZoomOutAnimationIsShow:(BOOL)isShow
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (isShow) {
        scaleAnimation.fromValue = @(2.0);
        scaleAnimation.toValue = @(1.0);
    } else {
        scaleAnimation.fromValue = @(1.0);
        scaleAnimation.toValue = @(2.0);
    }
    return scaleAnimation;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.mode == ZLFlowChartList) {
        return self.stepArray.count;
    } else {
        return 2*ceilf(self.stepArray.count/3.0)-1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mode == ZLFlowChartList) {
        return 44;
    } else {
        if (indexPath.row % 2 == 0) {
            return 50;
        } else {
            return 30;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mode == ZLFlowChartList) {
        ZLFlowChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLFlowChartCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLFlowChartCell" owner:self options:nil] lastObject];
        }
        cell.labTopLine.backgroundColor = cell.labCircle.backgroundColor = cell.labBottomLine.backgroundColor = self.lineColor;
        
        cell.labTitle.text = [NSString stringWithFormat:@"%ld: %@", indexPath.row+1, self.stepArray[indexPath.row]];
        
        if (indexPath.row == 0) {
            cell.labTopLine.hidden = YES;
        } else {
            cell.labTopLine.hidden = NO;
        }
        if (indexPath.row == self.stepArray.count - 1) {
            cell.labBottomLine.hidden = YES;
        } else {
            cell.labBottomLine.hidden = NO;
        }
        
        if (indexPath.row == self.nowStepIndex) {
            cell.labTitle.textColor = self.highlightedColor;
        } else {
            cell.labTitle.textColor = self.normalColor;
        }
        
        return cell;
    } else {
        if (indexPath.row % 2 == 0) {
            //ZLFlowChartDefault
            ZLFlowChartCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLFlowChartCell2"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLFlowChartCell2" owner:self options:nil] lastObject];
            }
            
            cell.labMiddleLeft.textColor = cell.labMiddleRight.textColor = self.lineColor;
            
            cell.tag = indexPath.row/2;
            
            __weak typeof(ZLFlowChart *) weakSelf = self;
            
            [cell setHandler:^(NSInteger index) {
                weakSelf.selIndex = index;
                [weakSelf hide];
            }];
            
            NSInteger length = (self.stepArray.count-indexPath.row/2*3);
            length = length > 3 ? 3 : length;
            NSArray *arr = [self.stepArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row/2*3, length)]];
            
            [cell showTitleArray:arr reverse:!((indexPath.row/2)%2==0)];
            [cell setSelectStepIndex:self.nowStepIndex normalColor:self.normalColor highlightedColor:self.highlightedColor];
            
            return cell;
        } else {
            ZLSpaceArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLSpaceArrowCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZLSpaceArrowCell" owner:self options:nil] lastObject];
            }
            [cell showArrowWithIndexPathRow:indexPath.row];
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mode == ZLFlowChartList) {
        self.selIndex = indexPath.row;
        [self hide];
    }
}

@end
