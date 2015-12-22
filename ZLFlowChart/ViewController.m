//
//  ViewController.m
//  ZLFlowChart
//
//  Created by long on 15/12/21.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ViewController.h"
#import "ZLFlowChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)btnClick:(id)sender
{
    ZLFlowChart *flowChart = [[ZLFlowChart alloc] initWithTitle:@"test" stepArray:@[@"第1步", @"第2步", @"第3步", @"第4步", @"第5步", @"第6步", @"第7步", @"第8步", @"第9步", @"第10步", @"第11步", @"第12步", @"第13步", @"第14步", @"第15步"] showAnimationType:ZLFlowChartAnimationRotation | ZLFlowChartAnimationZoomIn hideAnimationType:ZLFlowChartAnimationZoomIn | ZLFlowChartAnimationFade];
    [flowChart setHandler:^(NSInteger index) {
        NSLog(@"选中的步骤:%ld", index);
    }];
    [flowChart showWithSelectStepIndex:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
