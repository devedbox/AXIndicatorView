//
//  AXActivityIndicatorView.m
//  AXIndicatorView
//
//  Created by devedbox on 2016/10/7.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXActivityIndicatorView.h"

@interface AXActivityIndicatorView ()
/// Shape layer.
@property(strong, nonatomic) CADisplayLink *displayLink;
@end

@implementation AXActivityIndicatorView
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
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawComponents];
}

- (void)drawComponents {
    // Get the 12 components of the bounds.
    CGFloat angle = M_PI*2/12;
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    UIColor *tintColor = self.tintColor?:[UIColor blackColor];
    // Draw all the possilbe line using the proper tint color.
    for (int64_t i = _animatedColorIndex; i < _animatedColorIndex+_drawingComponents; i++) [self drawLineWithAngle:angle*i-M_PI_2 context:cxt tintColor:_animating?[tintColor colorWithAlphaComponent:((float)i-(float)_animatedColorIndex)/12.0]:tintColor];
}

#pragma mark - Getters
- (BOOL)isAnimating {
    return _animating;
}

- (CADisplayLink *)displayLink {
    return _displayLink;
}

#pragma mark - Setters

- (void)setAnimatedColorIndex:(int64_t)animatedColorIndex {
    _animatedColorIndex = animatedColorIndex;
    [self setNeedsDisplay];
}

- (void)setDrawingComponents:(int64_t)drawingComponents {
    _drawingComponents = MIN(12, drawingComponents);
    [self setNeedsDisplay];
}

- (void)setAnimating:(BOOL)animating {
    _animating = animating;
    
    if (animating) {
        [self addColorIndexAnimation];
    } else {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

#pragma mark - Helper
- (void)drawLineWithAngle:(CGFloat)angle context:(CGContextRef)context tintColor:(UIColor *)tintColor {
    CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGRect box = CGRectInset(self.bounds, _lineWidth, _lineWidth);
    CGFloat deatla = MIN(box.size.width, box.size.height);
    box.origin.x += fabs(box.size.width-deatla)*.5;
    box.origin.y += fabs(box.size.height-deatla)*.5;
    box.size.width = deatla;
    box.size.height = deatla;
    
    // Get the begin point of the bounds.
    CGFloat radius = CGRectGetWidth(box)/2;
    CGPoint beginPoint = CGPointMake(self.center.x-self.frame.origin.x+radius*0.5*cos(angle), self.center.y-self.frame.origin.y+radius*0.5*sin(angle));
    CGPoint endPoint = CGPointMake(self.center.x-self.frame.origin.x+radius*cos(angle), self.center.y-self.frame.origin.y+radius*sin(angle));
    
    CGContextMoveToPoint(context, beginPoint.x, beginPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    CGContextStrokePath(context);
}

- (void)addColorIndexAnimation {
    if (!self.displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    }
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_10_0
    self.displayLink.frameInterval = 3;
#else
    if ([self.displayLink respondsToSelector:@selector(setPreferredFramesPerSecond:)] && kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_9_4) {
        self.displayLink.preferredFramesPerSecond = 20;
    }
#endif
}

- (void)handleDisplayLink:(CADisplayLink *)sender {
    if (++_animatedColorIndex > 12) {
        _animatedColorIndex = 0;
    }
    [self setAnimatedColorIndex:_animatedColorIndex];
}
@end
