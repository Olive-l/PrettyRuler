//
//  ViewController.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import "ViewController.h"
#import "TXHPrettyRuler.h"

@interface ViewController () <TXHPrettyRulerDelegate>

@end

@implementation ViewController {
    UILabel *showLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个显示的标签
    showLabel = [[UILabel alloc] init];
    showLabel.font = [UIFont systemFontOfSize:20.f];
    showLabel.text = @"当前刻度值:20";
    showLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    
    // 2.创建 TXHRrettyRuler 对象 并设置代理对象
    TXHPrettyRuler *ruler = [[TXHPrettyRuler alloc] initWithFrame:CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 20 * 2, 140)];
    ruler.rulerDeletate = self;
    ruler.unitStr = @"m";
    ruler.minValue = 1;
    ruler.maxValue = 20;
    [self.view addSubview:ruler];
}

- (void)TXHPrettyRulerValue:(CGFloat)value {
    showLabel.text = [NSString stringWithFormat:@"当前刻度值: %.1f", value];
}

@end
