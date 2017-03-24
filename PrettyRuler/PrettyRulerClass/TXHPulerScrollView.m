//
//  TXHPulerScrollView.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Olive. All rights reserved.
//

#import "TXHPulerScrollView.h"

@implementation TXHPulerScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
    
    self.contentOffset = CGPointMake(DISTANCEVALUE * ((rulerValue-self.mininumValue) / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
}

- (void)setRulerValue:(CGFloat)rulerValue animation:(BOOL)animation
{
    _rulerValue = rulerValue;
    
    [self setContentOffset:CGPointMake(DISTANCEVALUE * ((rulerValue-self.mininumValue) / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0) animated:animation];
}

- (void)drawRuler {
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    for (int i = 0; i <= self.rulerCount; i++) {
        
        if ( (0 == i) || (i % 10 == 0) ) {
            
            UILabel *rule = [[UILabel alloc] init];
            //            rule.textColor = [UIColor blackColor];
            //            rule.text = [NSString stringWithFormat:@"%.0f KM",(i+1) * [self.rulerAverage floatValue]];
            //            UIFont *font = [UIFont systemFontOfSize:9];
            //            CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : font }];
            //            rule.font = font;
            
            
            NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d ", (self.mininumValue + (i/10))] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
            NSString *str = self.unitStr;
            if (!str)
                str = @"";
            NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] init];
            [mAttr appendAttributedString:attr1];
            [mAttr appendAttributedString:attr2];
            
            rule.attributedText = mAttr;
            
            
            CGSize textSize = mAttr.size;
            
            
            
            CGPathMoveToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - 10);
            rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height, textSize.width, textSize.height);
            [self addSubview:rule];
        }
        else if (i % 5 == 0) {
            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - 10 - 10);
        }
        else
        {
            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - 10 - 20);
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    CGPathRelease(pathRef1);
    CGPathRelease(pathRef2);
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT, 0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT);
    self.contentInset = edge;
    
    
    self.contentSize = CGSizeMake(self.rulerCount * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f, self.rulerHeight);
    
    
    if (_rulerValue) {
        self.contentOffset = CGPointMake(DISTANCEVALUE * ((_rulerValue-self.mininumValue) / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
    }
}

@end
