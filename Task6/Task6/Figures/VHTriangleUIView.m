//
//  TriangleUIView.m
//  Task6
//
//  Created by Vasil' on 6/19/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHTriangleUIView.h"
#import "VHColors.h"

static NSInteger imgAngle = 0;

@interface VHTriangleUIView ()

@end

@implementation VHTriangleUIView

- (void)layoutSubviews{
    [super layoutSubviews];

    [self rotateTriangle];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);

    CGContextSetRGBFillColor(ctx, 0.20, 0.76, 0.63, 1);
    CGContextFillPath(ctx);
}

- (void)rotateTriangle {
    [self.layer removeAnimationForKey:@"rotation"];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotateAnimation.duration = 5;
    rotateAnimation.additive = YES;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.repeatCount = INFINITY;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:(imgAngle * M_PI / 180)];
    rotateAnimation.toValue = [NSNumber numberWithFloat:((imgAngle + 360) * M_PI / 180)];
    [self.layer addAnimation:rotateAnimation forKey:@"rotation"];
    
    imgAngle += 90;
    if (imgAngle > 360) {
        imgAngle = 0;
    }
}

@end
