//
//  TXHRulerScrollView.h
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCELEFTANDRIGHT 8.f // 标尺左右距离
#define DISTANCEVALUE 8.f // 每隔刻度实际长度8个点
#define DISTANCETOPANDBOTTOM 0.f // 标尺上下距离

@interface TXHPulerScrollView : UIScrollView

@property (nonatomic) int mininumValue;
@property (nonatomic) int maximumValue;

@property (nonatomic) int rulerCount;

@property (nonatomic) NSNumber * rulerAverage;

@property (nonatomic) NSUInteger rulerHeight;

@property (nonatomic) NSUInteger rulerWidth;

@property (nonatomic) CGFloat rulerValue;

@property (nonatomic) BOOL mode;

@property (nonatomic, copy) NSString *unitStr;

- (void)drawRuler;

- (void)setRulerValue:(CGFloat)rulerValue animation:(BOOL)animation;

@end
