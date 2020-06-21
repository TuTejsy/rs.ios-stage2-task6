//
//  VHSquareView.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHSquareView.h"

@interface VHSquareView ()

@end

@implementation VHSquareView

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [self moveSquare];
}

- (void)moveSquare {
    [self.layer removeAnimationForKey:@"transition"];
    
    CAKeyframeAnimation *transitionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    transitionAnimation.duration = 2;
    transitionAnimation.repeatCount = INFINITY;
    transitionAnimation.removedOnCompletion = NO;
    transitionAnimation.values = @[
        @(-(self.bounds.size.height / 10)),
        @((self.bounds.size.height / 10)),
        @(-(self.bounds.size.height / 10)),
    ];
    transitionAnimation.keyTimes = @[@0, @0.4, @1];
    transitionAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
    ];
    [self.layer addAnimation:transitionAnimation forKey:@"transition"];
}

@end
