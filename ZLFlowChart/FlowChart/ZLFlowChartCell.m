//
//  ZLFlowChartCell.m
//  ZLFlowChart
//
//  Created by long on 15/12/21.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLFlowChartCell.h"

@implementation ZLFlowChartCell

- (void)awakeFromNib {
    self.labCircle.layer.masksToBounds = YES;
    self.labCircle.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
