//
//  VHInfoTableViewController.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import <Photos/Photos.h>
#import "VHConstants.h"
#import "VHColors.h"
#import "VHInfoTableViewController.h"
#import "FileInfoViewController.h"
#import "VHTableViewCell.h"

@interface VHInfoTableViewController () <VHTableViewCellDelegate>

@property(nonatomic, strong) PHFetchResult *assetsFetchResults;
@property(nonatomic, strong) PHCachingImageManager *imageManager;

@end

@implementation VHInfoTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"Info";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAssets];
    [self setupViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(updateTable)
        name:@"appDidBecomeActive"
      object:nil];
}

- (void)setupViews {
    UINib *nib = [UINib nibWithNibName:@"VHTableViewCell" bundle:nil];
    [self.tableView registerNib: nib forCellReuseIdentifier:@"infoCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)updateAssets {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    _assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    _imageManager = [[PHCachingImageManager alloc] init];
}

-(void)updateTable {
    [self updateAssets];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_assetsFetchResults count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLE_CELL_HEIGHT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    PHAsset *asset = _assetsFetchResults[indexPath.item];
    cell.asset = asset;
    cell.delegate = self;
    
    [_imageManager requestImageForAsset:asset targetSize:CGSizeMake(76, 76) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
        cell.image = result;
    }];
    
    return cell;
}


#pragma mark - VHTableViewCellDelegate

- (void)showFileInfoForAsset: (PHAsset *) asset {
    FileInfoViewController *viewController = [[FileInfoViewController alloc] initWithAsset:asset];
    
    [self.tabBarController.navigationController pushViewController:viewController animated:YES];
}


@end
