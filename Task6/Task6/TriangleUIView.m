//
//  TriangleUIView.m
//  Task6
//
//  Created by Vasil' on 6/19/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "TriangleUIView.h"
#import "VHColors.h"

@interface TriangleUIView ()

@property (nonatomic, strong) CAShapeLayer *colorDotLayer;

@end

@implementation TriangleUIView

- (instancetype)init {
    self = [super init];
    
    return self;
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

@end
