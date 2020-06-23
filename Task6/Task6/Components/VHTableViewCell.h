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

@protocol VHTableViewCellDelegate

-(void)showFileInfoForAsset: (PHAsset *) asset;

@end

@interface VHTableViewCell : UITableViewCell

@property(nonatomic, copy) UIImage *image;
@property(nonatomic, copy) PHAsset *asset;
@property(nonatomic, weak) NSObject<VHTableViewCellDelegate> *delegate;

@end

NS_ASSUME_NONNULL_END
