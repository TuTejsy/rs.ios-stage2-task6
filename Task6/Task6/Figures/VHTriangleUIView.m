//
//  TriangleUIView.m
//  Task6
//
//  Created by Vasil' on 6/19/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHTriangleUIView.h"
#import "VHColors.h"

@interface VHTriangleUIView ()

@end

@implementation VHTriangleUIView

-(void)layoutSubviews{
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
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setTransform:CGAffineTransformRotate(self.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self rotateTriangle];
        }
    }];
}

@end
