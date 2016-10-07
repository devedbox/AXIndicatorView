//
//  AXActivityIndicatorView.h
//  AXIndicatorView
//
//  Created by devedbox on 2016/10/7.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXActivityIndicatorView : UIView
/// Line width.
@property(assign, nonatomic) CGFloat lineWidth;
/// Drawing percent of the components.
@property(assign, nonatomic) int64_t drawingComponents;
/// Animating.
@property(assign, nonatomic, getter=isAnimating) BOOL animating;
/// Animated color index.
@property(assign, nonatomic) int64_t animatedColorIndex;


- (void)drawComponents;
@end
