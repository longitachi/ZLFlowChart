//
//  ZLFlowChart.h
//  ZLFlowChart
//
//  Created by long on 15/12/21.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    //无动画
    ZLFlowChartAnimationNone = 1 << 0,
    //渐隐
    ZLFlowChartAnimationFade = 1 << 1,
    //旋转
    ZLFlowChartAnimationRotation = 1 << 2,
    //向内缩放
    ZLFlowChartAnimationZoomIn = 1 << 3,
    //向外缩放
    ZLFlowChartAnimationZoomOut = 1 << 4
} ZLFlowChartAnimationType;

@interface ZLFlowChart : UIView

/**
 * 流程图标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 流程图数据源
 */
@property (nonatomic, strong) NSArray<NSString *> *stepArray;

/**
 * 流程图左侧指示线的颜色
 * 默认 orange color
 */
@property (nonatomic, assign) UIColor *lineColor;

/**
 * 表格未选中行标题默认颜色
 * 默认 black color
 */
@property (nonatomic, assign) UIColor *normalColor;

/**
 * 表格选中行标题高亮颜色
 * 默认 orange color
 */
@property (nonatomic, assign) UIColor *highlightedColor;

/**
 * 当前 step 索引
 */
@property (nonatomic, assign) NSInteger nowStepIndex;

/**
 * 显示时动画类型
 */
@property (nonatomic, assign) ZLFlowChartAnimationType showAnimationType;

/**
 * 隐藏时动画类型
 */
@property (nonatomic, assign) ZLFlowChartAnimationType hideAnimationType;

/**
 * call back
 */
@property (nonatomic, copy) void (^handler)(NSInteger);


- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


/**
 * @brief 初始化流程图
 * @param title     标题
 * @param stepArray 流程步骤数组
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                    stepArray:(NSArray<NSString *> *)stepArray;

/**
 * @brief 初始化流程图，并直接指定动画类型
 * @param title             标题
 * @param stepArray         流程步骤数组
 * @param showAnimationType 显示时动画类型 动画组合可用 "|" 连接
 * @param hideAnimationType 显示时动画类型 动画组合可用 "|" 连接
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                    stepArray:(NSArray<NSString *> *)stepArray
            showAnimationType:(ZLFlowChartAnimationType)showAnimationType
            hideAnimationType:(ZLFlowChartAnimationType)hideAnimationType;

/**
 * @brief 显示流程图，同时设置当前步骤的下标
 * @param selIndex 从0开始计算，即和步骤数组保持同步
 */
- (void)showWithSelectStepIndex:(NSInteger)selIndex;

/**
 * @brief 显示流程图
 */
- (void)show;

@end

NS_ASSUME_NONNULL_END