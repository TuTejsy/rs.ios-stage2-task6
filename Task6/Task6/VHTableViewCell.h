//
//  VHTableViewCell.h
//  Task6
//
//  Created by Vasil' on 6/21/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VHTableViewCell : UITableViewCell

@property(nonatomic, copy) UIImage *image;
@property(nonatomic, copy) PHAsset *asset;

@end

NS_ASSUME_NONNULL_END
