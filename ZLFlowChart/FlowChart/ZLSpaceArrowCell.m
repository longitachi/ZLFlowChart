//
//  ZLSpaceArrowCell.m
//  ZLFlowChart
//
//  Created by long on 15/12/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLSpaceArrowCell.h"

@implementation ZLSpaceArrowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showArrowWithIndexPathRow:(NSInteger)row
{
    if ((row + 1) % 4 == 0) {
        self.labLeftArrow.hidden = NO;
        self.labRightArrow.hidden = YES;
    } else {
        self.labLeftArrow.hidden = YES;
        self.labRightArrow.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
