//
//  FileInfoViewController.m
//  Task6
//
//  Created by Vasil' on 6/22/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import <Photos/Photos.h>
#import "FileInfoViewController.h"
#import "VHColors.h"

static NSInteger const SCROLL_VIEW_PADDING = 16;

@interface FileInfoViewController ()

@property(nonatomic, copy) PHAsset *asset;
@property(nonatomic, strong) PHAssetResource *resource;
@property(nonatomic, copy) PHCachingImageManager *imageManager;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation FileInfoViewController

- (instancetype)initWithAsset: (PHAsset*) asset {
    self = [super init];
    
    if (self) {
        _imageManager = [[PHCachingImageManager alloc] init];
        _asset = asset;
        NSArray *resources = [PHAssetResource assetResourcesForAsset:_asset];
        _resource = resources[0];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.title = _resource.originalFilename;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [VHColors white];
    scrollView.alwaysBounceVertical = YES;
    scrollView.contentMode = UIViewContentModeScaleAspectFit;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [scrollView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
    ]];
    
    
    // configure image
    
    double sizeFactor = (self.view.bounds.size.width - 2 * SCROLL_VIEW_PADDING) / _asset.pixelWidth;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLL_VIEW_PADDING, SCROLL_VIEW_PADDING,  self.view.bounds.size.width - 2 * SCROLL_VIEW_PADDING, _asset.pixelHeight * sizeFactor)];
    [scrollView addSubview:_imageView];
    
    [_imageManager requestImageForAsset:_asset targetSize:CGSizeMake(_asset.pixelWidth, _asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *image, NSDictionary *info) {
        if (image) {
            self.imageView.image = image;
        }
    }];
    
    
    // configure labels
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss dd.MM.YYYY"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    UILabel *creationDateLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *creationAttributedText = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"Creation date: %@", [dateFormatter stringFromDate:_asset.creationDate]]];
    [creationAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors gray] range: NSMakeRange(0, 13)];
    [creationAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors black] range: NSMakeRange(13, creationAttributedText.length - 13)];
    
    creationDateLabel.attributedText = creationAttributedText;
    
    creationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:creationDateLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [creationDateLabel.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:SCROLL_VIEW_PADDING],
        [creationDateLabel.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-SCROLL_VIEW_PADDING],
        [creationDateLabel.topAnchor constraintEqualToAnchor: _imageView.bottomAnchor constant:SCROLL_VIEW_PADDING * 2],
    ]];
    
    UILabel *modificationDateLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *modificationAttributedText = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"Modification date: %@", [dateFormatter stringFromDate:_asset.modificationDate]]];
    [modificationAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors gray] range: NSMakeRange(0, 17)];
    [modificationAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors black] range: NSMakeRange(17, modificationAttributedText.length - 17)];
    
    modificationDateLabel.attributedText = modificationAttributedText;
    
    modificationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:modificationDateLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [modificationDateLabel.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:SCROLL_VIEW_PADDING],
        [modificationDateLabel.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-SCROLL_VIEW_PADDING],
        [modificationDateLabel.topAnchor constraintEqualToAnchor: creationDateLabel.bottomAnchor constant:SCROLL_VIEW_PADDING],
    ]];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *typeAttributedText = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"Type: %@", [self getStringTypeFromResourceType: _resource.type]]];
    [typeAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors gray] range: NSMakeRange(0, 4)];
    [typeAttributedText addAttribute: NSForegroundColorAttributeName value: [VHColors black] range: NSMakeRange(4, typeAttributedText.length - 4)];
    
    typeLabel.attributedText = typeAttributedText;
    
    typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:typeLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [typeLabel.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:SCROLL_VIEW_PADDING],
        [typeLabel.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-SCROLL_VIEW_PADDING],
        [typeLabel.topAnchor constraintEqualToAnchor: modificationDateLabel.bottomAnchor constant:SCROLL_VIEW_PADDING],
    ]];
    
    
    // configure button
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [VHColors yellow];
    
    [button setTitle:@"Share" forState:UIControlStateNormal];
    [button setTitleColor:[VHColors black] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    button.layer.cornerRadius = 28;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:55],
        [button.widthAnchor constraintEqualToConstant:self.view.bounds.size.width * 0.7],
        [button.topAnchor constraintEqualToAnchor:typeLabel.bottomAnchor constant:SCROLL_VIEW_PADDING * 2],
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
    
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    scrollView.contentSize = CGSizeMake(_imageView.bounds.size.width + 2 * SCROLL_VIEW_PADDING, _imageView.bounds.size.height + 2 * SCROLL_VIEW_PADDING + 220);
}

- (void)buttonTapped {
    [self shareFileOfResourceType:_resource.type];
}

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) shareFileOfResourceType: (PHAssetResourceType) type {
    NSMutableArray *activityItems = [NSMutableArray array];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    typeof(self) __weak weakSelf = self;
    
    if (type == PHAssetResourceTypeVideo) {
        [_imageManager requestExportSessionForVideo: _asset options:nil exportPreset:AVAssetExportPresetPassthrough resultHandler:^(AVAssetExportSession *exportSession, NSDictionary *info) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* videoPath = [documentsDirectory stringByAppendingPathComponent:weakSelf.resource.originalFilename];
            NSFileManager *manager = [NSFileManager defaultManager];
            
            NSError *error;
            if ([manager fileExistsAtPath:videoPath]) {
                BOOL success = [manager removeItemAtPath:videoPath error:&error];
                if (success) {
                    NSLog(@"Already exist. Removed!");
                }
            }
            
            NSURL *outputURL = [NSURL fileURLWithPath:videoPath];
            exportSession.outputFileType=AVFileTypeQuickTimeMovie;
            exportSession.outputURL=outputURL;
            
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                if (exportSession.status == AVAssetExportSessionStatusFailed) {
                    NSLog(@"failed");
                } else if(exportSession.status == AVAssetExportSessionStatusCompleted){
                    NSLog(@"completed!");
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        NSArray *activityItems = [NSArray arrayWithObjects:outputURL, nil];
                        
                        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
                        activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
                            NSError *error;
                            if ([manager fileExistsAtPath:videoPath]) {
                                BOOL success = [manager removeItemAtPath:videoPath error:&error];
                                if (success) {
                                    NSLog(@"Successfully removed temp video!");
                                }
                            }
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        };
                        [weakSelf presentViewController:activityVC animated:YES completion:nil];
                    });
                }
            }];
        }];
    } else if (type == PHAssetResourceTypePhoto) {
        options.synchronous = YES;
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        options.resizeMode = PHImageRequestOptionsResizeModeNone;
        
        [_imageManager requestImageDataForAsset:_asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* imagePath = [documentsDirectory stringByAppendingPathComponent:weakSelf.resource.originalFilename];
            NSFileManager *manager = [NSFileManager defaultManager];
            
            NSError *error;
            if ([manager fileExistsAtPath:imagePath]) {
                BOOL success = [manager removeItemAtPath:imagePath error:&error];
                if (success) {
                    NSLog(@"Already exist. Removed!");
                }
            }
            
            [imageData writeToFile:imagePath atomically:YES];
            NSURL *outputURL = [NSURL fileURLWithPath:imagePath];
            
            [activityItems addObject: outputURL];
        }];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        // prevent sharing to gallery again
        activityVC.excludedActivityTypes = @[UIActivityTypeSaveToCameraRoll];
        
        [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    } else {
        return;
    }
}

- (NSString*) getStringTypeFromResourceType: (PHAssetResourceType) type {
    switch (type) {
        case PHAssetResourceTypeVideo:
            return @"Video";
            break;
            
        case PHAssetResourceTypePhoto:
            return @"Image";
        break;
            
        case PHAssetResourceTypeAudio:
            return @"Audio";
        break;
            
        default:
            return @"Other";
            
            break;
    }
    
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
