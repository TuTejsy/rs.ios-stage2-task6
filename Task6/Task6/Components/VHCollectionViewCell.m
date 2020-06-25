//
//  VHCollectionViewCell.m
//  Task6
//
//  Created by Vasil' on 6/23/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHCollectionViewCell.h"

@interface VHCollectionViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation VHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
}

@end
