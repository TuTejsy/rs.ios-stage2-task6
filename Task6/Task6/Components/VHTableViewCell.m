//
//  VHTableViewCell.m
//  Task6
//
//  Created by Vasil' on 6/21/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHTableViewCell.h"
#import "VHColors.h"

@interface VHTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *typeImageView;

@end

@implementation VHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [VHColors yellowHighlighted];
    self.layer.masksToBounds = YES;
    self.selectedBackgroundView = selectedView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.delegate showFileInfoForAsset: _asset];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.nameLabel.text = @"";
    self.sizeLabel.text = @"";
    self.typeImageView.image = nil;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    typeof(self) __weak weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *resources = [PHAssetResource assetResourcesForAsset:weakSelf.asset];
        
        if ([resources count] > 0) {
            PHAssetResource* resource = resources[0];
            
            weakSelf.nameLabel.text = resource.originalFilename;
            [weakSelf setInfoForType: resource.type];
        }
    });
}

- (void)setInfoForType: (PHAssetResourceType) type {
    NSTimeInterval interval;
    NSDate *date;
    NSDateFormatter *dateFormatter;
    
    switch (type) {
        case PHAssetResourceTypePhoto:
            _typeImageView.image = [UIImage imageNamed:@"image"];
            _sizeLabel.text = [NSString stringWithFormat:@"%lux%lu", (unsigned long)_asset.pixelWidth, (unsigned long)_asset.pixelHeight];
            break;
            
        case PHAssetResourceTypeVideo:
            _typeImageView.image = [UIImage imageNamed:@"video"];
            
            interval = _asset.duration;
            date = [NSDate dateWithTimeIntervalSince1970:interval];
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"mm:ss"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            
            _sizeLabel.text = [NSString stringWithFormat:@"%lux%lu %@", (unsigned long)_asset.pixelWidth, (unsigned long)_asset.pixelHeight, [dateFormatter stringFromDate:date]];
            
            break;
            
        case PHAssetResourceTypeAudio:
            _typeImageView.image = [UIImage imageNamed:@"audio"];
            
            _sizeLabel.text = [dateFormatter stringFromDate:date];
            break;
            
        default:
            _typeImageView.image = [UIImage imageNamed:@"other"];
            _sizeLabel.text = @"";
            break;
    }
}

@end
