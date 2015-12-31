//
//  ZLFlowChartCell2.m
//  ZLFlowChart
//
//  Created by long on 15/12/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLFlowChartCell2.h"

@implementation ZLFlowChartCell2

- (void)awakeFromNib {
    [self setBtnStyle:self.btnLeft];
    [self setBtnStyle:self.btnMiddle];
    [self setBtnStyle:self.btnRight];
}

- (void)setBtnStyle:(UIButton *)btn
{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.0f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1.0f;
    btn.titleLabel.numberOfLines = 2;
    btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

#pragma mark - 旋转箭头
- (void)setArrowTransformAngle:(double)angle
{
    self.labMiddleLeft.transform = CGAffineTransformMakeRotation(angle);
    self.labMiddleRight.transform = CGAffineTransformMakeRotation(angle);
}

#pragma mark - 设置选中按钮
- (void)setSelectStepIndex:(NSInteger)index normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor
{
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:normalColor forState:UIControlStateNormal];
            [btn setTitleColor:highlightedColor forState:UIControlStateSelected];
            
            if (btn.tag == index) {
                btn.selected = YES;
                btn.layer.borderColor = highlightedColor.CGColor;
            } else {
                btn.selected = NO;
                btn.layer.borderColor = normalColor.CGColor;
            }
        }
    }
}

- (void)showTitleArray:(NSArray *)titleArray reverse:(BOOL)reverse
{
    self.btnLeft.hidden = NO;
    self.btnMiddle.hidden = NO;
    self.btnRight.hidden = NO;
    self.labMiddleLeft.hidden = NO;
    self.labMiddleRight.hidden = NO;
    
    if (!reverse) {
        [self setArrowTransformAngle:0];
        //正向
        if (titleArray.count == 3) {
            [self.btnLeft setTitle:titleArray[0] forState:UIControlStateNormal];
            [self.btnMiddle setTitle:titleArray[1] forState:UIControlStateNormal];
            [self.btnRight setTitle:titleArray[2] forState:UIControlStateNormal];
            self.btnLeft.tag = self.tag * 3;
            self.btnMiddle.tag = self.tag * 3 + 1;
            self.btnRight.tag = self.tag * 3 + 2;
        } else if (titleArray.count == 2) {
            [self.btnLeft setTitle:titleArray[0] forState:UIControlStateNormal];
            [self.btnMiddle setTitle:titleArray[1] forState:UIControlStateNormal];
            self.btnLeft.tag = self.tag * 3;
            self.btnMiddle.tag = self.tag * 3 + 1;
            self.labMiddleRight.hidden = YES;
            self.btnRight.hidden = YES;
        } else {
            [self.btnLeft setTitle:titleArray[0] forState:UIControlStateNormal];
            self.btnLeft.tag = self.tag * 3;
            self.labMiddleLeft.hidden = YES;
            self.labMiddleRight.hidden = YES;
            self.btnMiddle.hidden = YES;
            self.btnRight.hidden = YES;
        }
    } else {
        //反向
        [self setArrowTransformAngle:M_PI];
        if (titleArray.count == 3) {
            [self.btnRight setTitle:titleArray[0] forState:UIControlStateNormal];
            [self.btnMiddle setTitle:titleArray[1] forState:UIControlStateNormal];
            [self.btnLeft setTitle:titleArray[2] forState:UIControlStateNormal];
            self.btnLeft.tag = self.tag * 3 + 2;
            self.btnMiddle.tag = self.tag * 3 + 1;
            self.btnRight.tag = self.tag * 3;
        } else if (titleArray.count == 2) {
            [self.btnRight setTitle:titleArray[0] forState:UIControlStateNormal];
            [self.btnMiddle setTitle:titleArray[1] forState:UIControlStateNormal];
            self.btnMiddle.tag = self.tag * 3 + 1;
            self.btnRight.tag = self.tag * 3;
            self.labMiddleLeft.hidden = YES;
            self.btnLeft.hidden = YES;
        } else {
            [self.btnRight setTitle:titleArray[0] forState:UIControlStateNormal];
            self.btnRight.tag = self.tag * 3;
            self.labMiddleLeft.hidden = YES;
            self.labMiddleRight.hidden = YES;
            self.btnMiddle.hidden = YES;
            self.btnLeft.hidden = YES;
        }
    }
    
    [self.btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMiddle addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn
{
    if (self.handler) {
        self.handler(btn.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
