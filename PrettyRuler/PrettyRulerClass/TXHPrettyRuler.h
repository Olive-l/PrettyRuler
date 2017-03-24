//
//  TXHPrettyRuler.h
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2017 Olive. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol TXHPrettyRulerDelegate <NSObject>

@optional
- (void)TXHPrettyRulerValue:(CGFloat)value;

@end

@interface TXHPrettyRuler : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id <TXHPrettyRulerDelegate> rulerDeletate;

@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValue;

@property (nonatomic, copy) NSString *unitStr;  // the unit beyond the ruler value

@property (nonatomic, assign) CGFloat currentValue;

@property (nonatomic, assign) BOOL continuous;  // return the value continuously or not. default: YES

- (void)setCurrentValue:(CGFloat)currentValue animation:(BOOL)animation;

@end
