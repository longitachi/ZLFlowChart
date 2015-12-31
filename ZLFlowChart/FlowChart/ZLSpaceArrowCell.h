//
//  ZLSpaceArrowCell.h
//  ZLFlowChart
//
//  Created by long on 15/12/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSpaceArrowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labLeftArrow;
@property (weak, nonatomic) IBOutlet UILabel *labRightArrow;

- (void)showArrowWithIndexPathRow:(NSInteger)row;

@end
