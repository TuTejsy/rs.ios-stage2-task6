//
//  VHSquareView.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHSquareView.h"

@implementation VHSquareView

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [self moveSquare];
}

- (void)moveSquare {
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(self.bounds.size.height / 10));
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, (self.bounds.size.height / 10));
        } completion:^(BOOL finished){
            [self moveSquare];
        }
         ];
    }];
}

@end
