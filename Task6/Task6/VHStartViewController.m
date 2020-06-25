//
//  ViewController.m
//  Task6
//
//  Created by Vasil' on 6/19/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHStartViewController.h"
#import "VHColors.h"
#import "VHConstants.h"
#import "VHCircleView.h"
#import "VHSquareView.h"
#import "VHTriangleUIView.h"
#import "VHInfoTableViewController.h"
#import "VHGalleryCollectionViewController.h"
#import "VHHomeViewController.h"

@interface VHStartViewController ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) VHCircleView *circleView;
@property (nonatomic, strong) VHSquareView *squareView;
@property (nonatomic, strong) VHTriangleUIView *trinagleView;

@end

@implementation VHStartViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _tabBarController = [[UITabBarController alloc] init];
        _tabBarController.tabBar.tintColor = [VHColors black];
        _tabBarController.tabBar.translucent = NO;
        [_tabBarController.navigationItem setHidesBackButton: YES];
        
        VHInfoTableViewController *infoTableViewController = [[VHInfoTableViewController alloc] init];
        infoTableViewController.tabBarItem.image = [UIImage imageNamed:@"info_unselected"];
        infoTableViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"info_selected"];
        infoTableViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

        VHGalleryCollectionViewController *galleryCollectionViewController = [[VHGalleryCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        galleryCollectionViewController.tabBarItem.image = [UIImage imageNamed:@"gallery_unselected"];
        galleryCollectionViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"gallery_selected"];
        galleryCollectionViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        VHHomeViewController *homeViewController = [[VHHomeViewController alloc] init];
        homeViewController.tabBarItem.image = [UIImage imageNamed:@"home_unselected"];
        homeViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
        homeViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        _tabBarController.viewControllers = @[infoTableViewController, galleryCollectionViewController, homeViewController];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [VHColors white];
    [self.navigationController.navigationBar setBarTintColor:[VHColors yellow]];
    [self.navigationController.navigationBar setTintColor:[VHColors black]];
    
    NSDictionary *navBarTitleOptions = @{
        NSFontAttributeName:  [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold],
        NSForegroundColorAttributeName: [VHColors black],
    };
    self.navigationController.navigationBar.titleTextAttributes = navBarTitleOptions;
    
    [self setupTitle];
    [self setupSquare];
    [self setupCircle];
    [self setupTriangle];
    [self setupButton];
}

- (void)setupTitle {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Are you ready?";
    titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.bounds.size.height * 0.15],
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
}

- (void)setupCircle {
    _circleView = [[VHCircleView alloc] init];
    _circleView.backgroundColor = [VHColors red];
    _circleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_circleView];
    
    [NSLayoutConstraint activateConstraints:@[
        [_circleView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_circleView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_circleView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-(self.view.bounds.size.height * 0.1)],
        [_circleView.rightAnchor constraintEqualToAnchor:_squareView.leftAnchor constant: -30],
    ]];
}


- (void)setupSquare {
    _squareView = [[VHSquareView alloc] init];
    _squareView.backgroundColor = [VHColors blue];
    _squareView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_squareView];
    
    [NSLayoutConstraint activateConstraints:@[
        [_squareView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_squareView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_squareView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_squareView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-(self.view.bounds.size.height * 0.1)],
    ]];
}

- (void)setupTriangle {
    _trinagleView = [[VHTriangleUIView alloc] init];
    _trinagleView.backgroundColor = [VHColors white];
    _trinagleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: _trinagleView];
    
    [NSLayoutConstraint activateConstraints:@[
        [_trinagleView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_trinagleView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [_trinagleView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-(self.view.bounds.size.height * 0.1)],
        [_trinagleView.leftAnchor constraintEqualToAnchor:_squareView.rightAnchor constant: 30],
    ]];
}


- (void)setupButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [VHColors yellow];
   
    [button setTitle:@"START" forState:UIControlStateNormal];
    [button setTitleColor:[VHColors black] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    button.layer.cornerRadius = 28;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:55],
        [button.widthAnchor constraintEqualToConstant:self.view.bounds.size.width * 0.7],
        [button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-(self.view.bounds.size.height * 0.15)],
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
    
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapped {
    self.navigationController.navigationBarHidden = NO;
    _tabBarController.selectedIndex = 1;
    [self.navigationController pushViewController:_tabBarController animated:YES];
}


@end
