//
//  VHGalleryCollectionViewController.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import <Photos/Photos.h>
#import "VHGalleryCollectionViewController.h"
#import "VHColors.h"
#import "VHCollectionViewCell.h"

@interface VHGalleryCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) PHFetchResult *assetsFetchResults;
@property(nonatomic, strong) UIImageView *fullImageView;
@property(nonatomic, strong) PHCachingImageManager *imageManager;

@end

@implementation VHGalleryCollectionViewController

static NSInteger const NUMBER_OF_COLUMNS = 3;
static NSString * const REUSE_IDENTIFIER = @"galleryCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"Gallery";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"VHCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:REUSE_IDENTIFIER];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(updateCollection)
        name:@"appDidBecomeActive"
      object:nil];
    
    [self updateAssets];
    [self setupViews];
}

- (void)setupViews {
    self.collectionView.backgroundColor = [VHColors white];
}

- (void)updateAssets {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    _assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    _imageManager = [[PHCachingImageManager alloc] init];
}

-(void)updateCollection {
    [self updateAssets];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_assetsFetchResults count] / NUMBER_OF_COLUMNS + ([_assetsFetchResults count] % NUMBER_OF_COLUMNS > 0 ? 1 : 0);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == ([_assetsFetchResults count] / NUMBER_OF_COLUMNS)) {
        NSInteger balance = [_assetsFetchResults count] % NUMBER_OF_COLUMNS;
        return balance > 0 ? balance : NUMBER_OF_COLUMNS;
    }
    
    return NUMBER_OF_COLUMNS;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    PHAsset *asset = _assetsFetchResults[(indexPath.section * NUMBER_OF_COLUMNS) + (indexPath.row)];
    
    CGFloat size = (self.view.bounds.size.width - 3 * (NUMBER_OF_COLUMNS + 1)) / NUMBER_OF_COLUMNS;

    [_imageManager requestImageForAsset:asset targetSize:CGSizeMake(size, size) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *image, NSDictionary *info) {
        if (image) {
            cell.image = image;
        }
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = self.collectionView.bounds.size.width / NUMBER_OF_COLUMNS - 5;
    
    return CGSizeMake(size, size);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,5,5,0);  // top, left, bottom, right
}


- (UIEdgeInsets)additionalSafeAreaInsets {
    return UIEdgeInsetsMake(5, 0, 0, 5); // top, left, bottom, right
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = _assetsFetchResults[(indexPath.section * NUMBER_OF_COLUMNS) + (indexPath.row)];
    [self addImageView];
    
    typeof(self) __weak weakSelf = self;
    
    [_imageManager requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *image, NSDictionary *info) {
        if (image) {
            weakSelf.fullImageView.image = image;
        }
    }];
}

- (void)removeImage {
    [_fullImageView removeFromSuperview];

    self.tabBarController.tabBar.hidden = NO;
}


- (void)addImageView {
    _fullImageView = [[UIImageView alloc] initWithFrame:self.navigationController.view.frame];
    _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    _fullImageView.backgroundColor = [UIColor blackColor];
    [_fullImageView setUserInteractionEnabled: YES];
    UISwipeGestureRecognizer *dismissSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(removeImage)];
    dismissSwipe.direction = (UISwipeGestureRecognizerDirectionDown |
                                 UISwipeGestureRecognizerDirectionUp);
    
    
    [_fullImageView addGestureRecognizer:dismissSwipe];
    self.tabBarController.tabBar.hidden = YES;

    [self.navigationController.view addSubview:_fullImageView];
}

@end
