//
//  UINavigationBar+VHNavigationBar.m
//  Task6
//
//  Created by Vasil' on 6/21/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "UINavigationBar+VHNavigationBar.h"

@implementation UINavigationBar()

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake([self superview].frame.size.width, 100);
}

@end
