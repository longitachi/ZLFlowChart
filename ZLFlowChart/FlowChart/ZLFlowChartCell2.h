//
//  ZLFlowChartCell2.h
//  ZLFlowChart
//
//  Created by long on 15/12/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLFlowChartCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnMiddle;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UILabel *labMiddleLeft;
@property (weak, nonatomic) IBOutlet UILabel *labMiddleRight;

@property (nonatomic, copy) void (^handler)(NSInteger);

- (void)showTitleArray:(NSArray *)titleArray reverse:(BOOL)reverse;

- (void)setSelectStepIndex:(NSInteger)index normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;

@end
