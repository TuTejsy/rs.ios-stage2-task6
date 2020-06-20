//
//  VHCircleView.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHCircleView.h"

@implementation VHCircleView

-(void)layoutSubviews{
    [super layoutSubviews];

    self.layer.cornerRadius = self.bounds.size.height / 2;
    [self pulseCircle];
}

- (void)pulseCircle {
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            
        } completion:^(BOOL finished){
            [self pulseCircle];
        }
         ];
    }];
}

@end
