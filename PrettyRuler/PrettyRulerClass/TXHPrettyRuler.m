//
//  TXHPrettyRuler.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2017 Olive. All rights reserved.
//

#import "TXHPrettyRuler.h"
#import "TXHPulerScrollView.h"

#define SHEIGHT 8 // 中间指示器顶部闭合三角形高度
#define INDICATORCOLOR [UIColor redColor].CGColor // 中间指示器颜色

@implementation TXHPrettyRuler {
    TXHPulerScrollView * rulerScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        rulerScrollView = [self rulerScrollView];
        
        // TODO: For in case to solve the confliction which if the super view is calss of UIScrollView
        rulerScrollView.tag = 0x0FFF;
        
        rulerScrollView.rulerHeight = frame.size.height;
        rulerScrollView.rulerWidth = frame.size.width;
        
        _maxValue = 0;
        _minValue = 0;
        
        self.continuous = YES;
        
        rulerScrollView.rulerAverage = @(0.1);
        rulerScrollView.mode = YES;
        
        [self addSubview:rulerScrollView];
        
        [self drawRacAndLine];
    }
    return self;
}


- (TXHPulerScrollView *)rulerScrollView {
    TXHPulerScrollView * rScrollView = [TXHPulerScrollView new];
    rScrollView.delegate = self;
    rScrollView.showsHorizontalScrollIndicator = NO;
    return rScrollView;
}


- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    //[rulerScrollView drawRuler];
}


- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        [rulerScrollView drawRuler];
    }
}


- (void)removeFromSuperview
{
    [rulerScrollView removeFromSuperview];
    rulerScrollView = nil;
    
    [super removeFromSuperview];
}


#pragma mark -
- (void)setMaxValue:(int)maxValue
{
    _maxValue = maxValue;
    
    rulerScrollView.maximumValue = maxValue;
    rulerScrollView.rulerCount = (maxValue-_minValue)*10;
}


- (void)setMinValue:(int)minValue
{
    _minValue = minValue;
    
    rulerScrollView.mininumValue = minValue;
    rulerScrollView.rulerCount = (_maxValue-minValue)*10;
}


- (void)setUnitStr:(NSString *)unitStr
{
    _unitStr = unitStr;
    rulerScrollView.unitStr = unitStr;
}


- (void)setCurrentValue:(CGFloat)currentValue
{
    if (_currentValue == currentValue)
        return;
    
    rulerScrollView.rulerValue = currentValue;
}


- (void)setCurrentValue:(CGFloat)currentValue animation:(BOOL)animation
{
    if (_currentValue == currentValue)
        return;
    
    [rulerScrollView setRulerValue:currentValue animation:animation];
}


#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(TXHPulerScrollView *)scrollView {
    
    if (scrollView.tag != 0x0FFF)
        return;
    
    if (self.continuous) {
        
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue]+self.minValue;
        if (ruleValue < self.minValue) {
            ruleValue = self.minValue;
        } else if (ruleValue > self.maxValue) {
            ruleValue = self.maxValue;
        }
        if (self.rulerDeletate && [self.rulerDeletate respondsToSelector:@selector(TXHPrettyRulerValue:)]) {
            if (!scrollView.mode) {
                scrollView.rulerValue = ruleValue;
            }
            scrollView.mode = NO;
            [self.rulerDeletate TXHPrettyRulerValue:ruleValue];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(TXHPulerScrollView *)scrollView {
    if (scrollView.tag != 0x0FFF)
        return;
    
    [self animationRebound:scrollView];
    
    if (!self.continuous) {
        
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue]+self.minValue;
        if (ruleValue < self.minValue) {
            ruleValue = self.minValue;
        } else if (ruleValue > self.maxValue) {
            ruleValue = self.maxValue;
        }
        if (self.rulerDeletate && [self.rulerDeletate respondsToSelector:@selector(TXHPrettyRulerValue:)]) {
            scrollView.rulerValue = ruleValue;
            [self.rulerDeletate TXHPrettyRulerValue:ruleValue];
        }
    }
}

- (void)scrollViewDidEndDragging:(TXHPulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag != 0x0FFF)
        return;
    
    [self animationRebound:scrollView];
    
    if (!self.continuous && !decelerate) {
        
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue]+self.minValue;
        if (ruleValue < self.minValue) {
            ruleValue = self.minValue;
        } else if (ruleValue > self.maxValue) {
            ruleValue = self.maxValue;
        }
        if (self.rulerDeletate && [self.rulerDeletate respondsToSelector:@selector(TXHPrettyRulerValue:)]) {
            scrollView.rulerValue = ruleValue;
            [self.rulerDeletate TXHPrettyRulerValue:ruleValue];
        }
    }
}

- (void)animationRebound:(TXHPulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
    CGFloat oX = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
    
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        oX = [self notRounding:oX afterPoint:0];
    }
    else {
        oX = [self notRounding:oX afterPoint:1];
    }
    
    CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}

- (void)drawRacAndLine {
    
#if NA_TOP_ARC
    // add by Olive. if do not need the arc on top
    // top margin line
    CAShapeLayer *topLineLayer = [CAShapeLayer layer];
    topLineLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    topLineLayer.fillColor = [UIColor clearColor].CGColor;
    topLineLayer.lineWidth = 1.f;
    topLineLayer.lineCap = kCALineCapSquare;
    
    CGMutablePathRef topLinePath = CGPathCreateMutable();
    CGPathMoveToPoint(topLinePath, NULL, 0, 0);
    CGPathAddLineToPoint(topLinePath, NULL, self.frame.size.width, 0);
    
    topLineLayer.path = topLinePath;
    [self.layer addSublayer:topLineLayer];
    CGPathRelease(topLinePath);
    // end by Joe
    
#else
    // 圆弧
    CAShapeLayer *shapeLayerArc = [CAShapeLayer layer];
    shapeLayerArc.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayerArc.fillColor = [UIColor clearColor].CGColor;
    shapeLayerArc.lineWidth = 1.f;
    shapeLayerArc.lineCap = kCALineCapButt;
    shapeLayerArc.frame = self.bounds;
    CGMutablePathRef pathArc = CGPathCreateMutable();
    CGPathMoveToPoint(pathArc, NULL, 0, DISTANCETOPANDBOTTOM);
    CGPathAddQuadCurveToPoint(pathArc, NULL, self.frame.size.width / 2, - 20, self.frame.size.width, DISTANCETOPANDBOTTOM);
    shapeLayerArc.path = pathArc;
    [self.layer addSublayer:shapeLayerArc];
    CGPathRelease(pathArc);
#endif
    
    // 渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.6f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    
    [self.layer addSublayer:gradient];
    
    // 红色指示器
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = [UIColor redColor].CGColor;
    shapeLayerLine.fillColor = INDICATORCOLOR;
    shapeLayerLine.lineWidth = 1.f;
    shapeLayerLine.lineCap = kCALineCapSquare;
    
    NSUInteger ruleHeight = 20; // 文字高度
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, self.frame.size.height - DISTANCETOPANDBOTTOM - ruleHeight);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, DISTANCETOPANDBOTTOM + SHEIGHT);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 - SHEIGHT / 2, DISTANCETOPANDBOTTOM);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 + SHEIGHT / 2, DISTANCETOPANDBOTTOM);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, DISTANCETOPANDBOTTOM + SHEIGHT);
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
    CGPathRelease(pathLine);
}

#pragma mark - tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler*roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces floatValue];
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
