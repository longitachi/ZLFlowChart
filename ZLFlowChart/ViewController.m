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

@property (nonatomic, assign) NSInteger nowStepIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nowStepIndex = 0;
}

- (IBAction)btnClick:(id)sender
{
    ZLFlowChart *flowChart = [[ZLFlowChart alloc] initWithTitle:@"流程图" stepArray:@[@"第1步", @"第2步", @"第3步", @"第4步", @"第5步(标题最多支持两行显示)", @"第6步", @"第7步", @"第8步", @"第9步", @"第10步"] showAnimationType:ZLFlowChartAnimationNone hideAnimationType:ZLFlowChartAnimationNone];
    flowChart.highlightedColor = [UIColor purpleColor];
    [self showAlertViewBtn:(UIButton *)sender fl:flowChart];
}

- (void)showAlertViewBtn:(UIButton *)btn fl:(ZLFlowChart *)flowChart
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择模式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"列表模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        flowChart.mode = ZLFlowChartList;
        flowChart.title = @"列表模式";
        //设置点击回调
        [flowChart setHandler:^(NSInteger index, NSString *selStepTitle) {
            [btn setTitle:[NSString stringWithFormat:@"选中的步骤下标:%ld,title:%@", index, selStepTitle] forState:UIControlStateNormal];
            weakSelf.nowStepIndex = index;
        }];
        //显示时候直接设置当前流程索引
        [flowChart showWithSelectStepIndex:_nowStepIndex];
        /*
         不需要设置索引则直接调用
         [flowChart show];
         */
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"默认模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        flowChart.mode = ZLFlowChartDefault;
        flowChart.title = @"默认模式";
        //设置点击回调
        [flowChart setHandler:^(NSInteger index, NSString *selStepTitle) {
            [btn setTitle:[NSString stringWithFormat:@"选中的步骤下标:%ld，title:%@", index, selStepTitle] forState:UIControlStateNormal];
            weakSelf.nowStepIndex = index;
        }];
        //显示时候直接设置当前流程索引
        [flowChart showWithSelectStepIndex:_nowStepIndex];
        /*
         不需要设置索引则直接调用
         [flowChart show];
         */
    }];
    [alert addAction:cancel];
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
