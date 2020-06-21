//
//  VHCircleView.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHCircleView.h"

@interface VHCircleView ()

@end

@implementation VHCircleView

-(void)layoutSubviews{
    [super layoutSubviews];

    self.layer.cornerRadius = self.bounds.size.height / 2;
    [self pulseCircle];
}

- (void)pulseCircle {
    [self.layer removeAnimationForKey:@"scale"];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 3;
    scaleAnimation.repeatCount = INFINITY;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.values = @[@0.9, @1.1, @0.9];
    scaleAnimation.keyTimes = @[@0, @0.333, @1];
    scaleAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
    ];
    [self.layer addAnimation:scaleAnimation forKey:@"scale"];
}

@end
