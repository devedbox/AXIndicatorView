//
//  AXBreachedAnnulusIndicatorView.m
//  AXIndicatorView
//
//  Created by devedbox on 2016/10/7.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXBreachedAnnulusIndicatorView.h"

@implementation AXBreachedAnnulusIndicatorView
@synthesize animating = _animating;
#pragma mark - Initializer
- (instancetype)init {
    if (self = [super init]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initializer];
}

- (void)initializer {
    _lineWidth = 2.0;
    _breach = M_PI_4;
    _duration = 1.6;
}

#pragma mark - Override

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *tintColor = self.tintColor?:[UIColor blackColor];
    
    CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGRect box = CGRectInset(self.bounds, _lineWidth, _lineWidth);
    CGFloat deatla = MIN(box.size.width, box.size.height);
    box.origin.x += fabs(box.size.width-deatla)*.5;
    box.origin.y += fabs(box.size.height-deatla)*.5;
    box.size.width = deatla;
    box.size.height = deatla;
    
    // Drawing.
    CGContextAddArc(context, CGRectGetMidX(box), CGRectGetMidY(box), deatla/2, 0, M_PI*2-_breach, 0);
    CGContextStrokePath(context);
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    
    [self setNeedsDisplay];
}

#pragma mark - Setters
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setBreach:(CGFloat)breach {
    _breach = breach;
    [self setNeedsDisplay];
}

- (void)setAnimating:(BOOL)animating {
    _animating = animating;
    
    if (animating) {
        CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotate.toValue = @(M_PI*2);
        rotate.duration = _duration;
        rotate.repeatCount = CGFLOAT_MAX;
        rotate.removedOnCompletion = NO;
        [self.layer addAnimation:rotate forKey:@"rotate"];
    } else {
        [self.layer removeAnimationForKey:@"rotate"];
    }
}
@end
