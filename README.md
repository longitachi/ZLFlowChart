# ZLFlowChart
* 实用流程图，多种动画效果
  * [效果图] (#效果图)
  * [支持的动画类型] (#动画类型)
  * [常用属性] (#常用属性)
  * [常用Api] (#常用Api)
  * [使用方法] (#使用方法)


####<a id="效果图"></a>效果图
![image](https://github.com/longitachi/ZLFlowChart/blob/master/效果图/展示及隐藏效果图.gif)

####<a id="动画类型"></a>动画类型
```objc
//支持动画组合
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
```

####<a id="常用属性"></a>常用属性
```objc
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
```
####<a id="常用Api"></a>常用Api
```objc
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
```
####<a id="使用方法"></a>使用方法
```objc
#import "ZLFlowChart.h"

ZLFlowChart *flowChart = [[ZLFlowChart alloc] initWithTitle:@"test" stepArray:@[@"第1步", @"第2步", @"第3步", @"第4步", @"第5步", @"第6步", @"第7步", @"第8步", @"第9步", @"第10步"] showAnimationType:ZLFlowChartAnimationRotation | ZLFlowChartAnimationZoomIn hideAnimationType:ZLFlowChartAnimationZoomOut | ZLFlowChartAnimationFade];
    //设置点击回调
[flowChart setHandler:^(NSInteger index) {
    NSLog(@"选中的步骤:%ld", index);
}];
//显示时候直接设置当前流程索引
[flowChart showWithSelectStepIndex:5];
/*
 不需要设置索引则直接调用
 [flowChart show];
 */
 ```
