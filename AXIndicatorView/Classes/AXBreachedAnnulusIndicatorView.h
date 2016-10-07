//
//  AXBreachedAnnulusIndicatorView.h
//  AXIndicatorView
//
//  Created by devedbox on 2016/10/7.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXBreachedAnnulusIndicatorView : UIView
/// Line width.
@property(assign, nonatomic) CGFloat lineWidth;
/// Breached angle.
@property(assign, nonatomic) CGFloat breach;
/// Duration.
@property(assign, nonatomic) NSTimeInterval duration;
/// Animating.
@property(assign, nonatomic, getter=isAnimating) BOOL animating;
@end
