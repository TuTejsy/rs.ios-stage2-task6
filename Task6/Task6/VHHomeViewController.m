//
//  VHHomeViewController.m
//  Task6
//
//  Created by Vasil' on 6/20/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "VHHomeViewController.h"
#import "VHConstants.h"
#import "VHColors.h"
#import "VHCircleView.h"
#import "VHSquareView.h"
#import "VHTriangleUIView.h"

@interface VHHomeViewController ()

@property(nonatomic, strong) UIView *deviceInfoView;
@property(nonatomic, strong) UIView *figuresView;
@property(nonatomic, strong) UIView *buttonsView;

@end

@implementation VHHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"RSSchool Task 6";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [VHColors white];
    
    [self setupDeviceInfo];
    [self setupButtons];
    [self setupFigures];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_deviceInfoView, _figuresView, _buttonsView]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 10;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.navigationController.navigationBar.frame.size.height],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [stackView.widthAnchor constraintEqualToConstant:(self.view.bounds.size.width * 0.8)],
        [stackView.centerXAnchor  constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)setupDeviceInfo {
    _deviceInfoView = [[UIView alloc] init];
    UIImage *logoImage = [UIImage imageNamed:@"apple.pdf"];
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = logoImage;
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [_deviceInfoView addSubview:logoView];
    
    [NSLayoutConstraint activateConstraints:@[
        [logoView.topAnchor constraintEqualToAnchor:_deviceInfoView.topAnchor],
        [logoView.leftAnchor constraintEqualToAnchor:_deviceInfoView.leftAnchor],
        [logoView.bottomAnchor constraintEqualToAnchor:_deviceInfoView.bottomAnchor],
        [logoView.widthAnchor constraintEqualToConstant:(self.view.bounds.size.width * 0.8 * 0.3)],
    ]];
    
    // labels
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    UILabel *deviceName = [[UILabel alloc] init];
    deviceName.text = [currentDevice name];
    deviceName.textColor = [VHColors black];
    deviceName.font = [UIFont boldSystemFontOfSize:16];
    deviceName.translatesAutoresizingMaskIntoConstraints = NO;
    [_deviceInfoView addSubview:deviceName];
    
    [NSLayoutConstraint activateConstraints:@[
        [deviceName.centerYAnchor constraintEqualToAnchor:_deviceInfoView.centerYAnchor constant:-30],
        [deviceName.leftAnchor constraintEqualToAnchor:logoView.rightAnchor constant:30],
        [deviceName.rightAnchor constraintEqualToAnchor:_deviceInfoView.rightAnchor constant:-16],
    ]];
    
    
    UILabel *deviceType = [[UILabel alloc] init];
    deviceType.text = [currentDevice model];
    deviceType.textColor = [VHColors black];
    deviceType.font = [UIFont boldSystemFontOfSize:16];
    deviceType.translatesAutoresizingMaskIntoConstraints = NO;
    [_deviceInfoView addSubview:deviceType];
    
    [NSLayoutConstraint activateConstraints:@[
        [deviceType.centerYAnchor constraintEqualToAnchor:_deviceInfoView.centerYAnchor ],
        [deviceType.leftAnchor constraintEqualToAnchor:logoView.rightAnchor constant:30],
        [deviceType.rightAnchor constraintEqualToAnchor:_deviceInfoView.rightAnchor constant:-16],
    ]];
    
    
    UILabel *deviceSystem = [[UILabel alloc] init];
    deviceSystem.text =[ NSString stringWithFormat:@"%@ %@", [currentDevice systemName],  [currentDevice systemVersion]];
    deviceSystem.textColor = [VHColors black];
    deviceSystem.font = [UIFont boldSystemFontOfSize:16];
    deviceSystem.translatesAutoresizingMaskIntoConstraints = NO;
    [_deviceInfoView addSubview:deviceSystem];
    
    [NSLayoutConstraint activateConstraints:@[
        [deviceSystem.centerYAnchor constraintEqualToAnchor:_deviceInfoView.centerYAnchor constant:30],
        [deviceSystem.leftAnchor constraintEqualToAnchor:logoView.rightAnchor constant:30],
        [deviceSystem.rightAnchor constraintEqualToAnchor:_deviceInfoView.rightAnchor constant:-16],
    ]];
}

- (void)setupButtons {
    _buttonsView = [[UIView alloc] init];
    
    UIButton *CVButton = [UIButton buttonWithType:UIButtonTypeSystem];
    CVButton.backgroundColor = [VHColors yellow];
    
    [CVButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [CVButton setTitleColor:[VHColors black] forState:UIControlStateNormal];
    CVButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    CVButton.layer.cornerRadius = 28;
    CVButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_buttonsView addSubview:CVButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [CVButton.heightAnchor constraintEqualToConstant:55],
        [CVButton.widthAnchor constraintEqualToConstant:self.view.bounds.size.width * 0.7],
        [CVButton.centerYAnchor constraintEqualToAnchor:_buttonsView.centerYAnchor constant:-35],
        [CVButton.centerXAnchor constraintEqualToAnchor:_buttonsView.centerXAnchor],
    ]];
    
    [CVButton addTarget:self action:@selector(CVButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.backgroundColor = [VHColors red];
    
    [startButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [startButton setTitleColor:[VHColors white] forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    startButton.layer.cornerRadius = 28;
    startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_buttonsView addSubview:startButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [startButton.heightAnchor constraintEqualToConstant:55],
        [startButton.widthAnchor constraintEqualToConstant:self.view.bounds.size.width * 0.7],
        [startButton.centerYAnchor constraintEqualToAnchor:_buttonsView.centerYAnchor constant:35],
        [startButton.centerXAnchor constraintEqualToAnchor:_buttonsView.centerXAnchor],
    ]];
    
    [startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupFigures {
    _figuresView = [[UIView alloc] init];
    
    // topBorder.
    UIView *topBorder = [[UIView alloc] init];
    topBorder.backgroundColor = [[VHColors gray] colorWithAlphaComponent:0.3];
    topBorder.layer.cornerRadius = 1;
    topBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [_figuresView addSubview:topBorder];
    
    [NSLayoutConstraint activateConstraints:@[
        [topBorder.topAnchor constraintEqualToAnchor:_figuresView.topAnchor],
        [topBorder.leftAnchor constraintEqualToAnchor:_figuresView.leftAnchor],
        [topBorder.rightAnchor constraintEqualToAnchor:_figuresView.rightAnchor],
        [topBorder.heightAnchor constraintEqualToConstant:2],
    ]];
    
    //bottomBorder

    UIView *bottomBorder = [[UIView alloc] init];
    bottomBorder.backgroundColor = [[VHColors gray] colorWithAlphaComponent:0.3];
    bottomBorder.layer.cornerRadius = 1;
    bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [_figuresView addSubview:bottomBorder];
    
    [NSLayoutConstraint activateConstraints:@[
        [bottomBorder.bottomAnchor constraintEqualToAnchor:_figuresView.bottomAnchor],
        [bottomBorder.leftAnchor constraintEqualToAnchor:_figuresView.leftAnchor],
        [bottomBorder.rightAnchor constraintEqualToAnchor:_figuresView.rightAnchor],
        [bottomBorder.heightAnchor constraintEqualToConstant:2],
    ]];
    
    //figures
    VHSquareView *squareView = [[VHSquareView alloc] init];
    squareView.backgroundColor = [VHColors blue];
    squareView.translatesAutoresizingMaskIntoConstraints = NO;
    [_figuresView addSubview:squareView];
    
    [NSLayoutConstraint activateConstraints:@[
        [squareView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [squareView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [squareView.centerXAnchor constraintEqualToAnchor:_figuresView.centerXAnchor],
        [squareView.centerYAnchor constraintEqualToAnchor:_figuresView.centerYAnchor],
    ]];
    
    VHCircleView *circleView = [[VHCircleView alloc] init];
    circleView.backgroundColor = [VHColors red];
    circleView.translatesAutoresizingMaskIntoConstraints = NO;
    [_figuresView addSubview:circleView];
    
    [NSLayoutConstraint activateConstraints:@[
        [circleView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [circleView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [circleView.centerYAnchor constraintEqualToAnchor:_figuresView.centerYAnchor],
        [circleView.rightAnchor constraintEqualToAnchor:squareView.leftAnchor constant: -30],
    ]];
    
    VHTriangleUIView *trinagleView = [[VHTriangleUIView alloc] init];
    trinagleView.backgroundColor = [VHColors white];
    trinagleView.translatesAutoresizingMaskIntoConstraints = NO;
    [_figuresView addSubview: trinagleView];
    
    [NSLayoutConstraint activateConstraints:@[
        [trinagleView.heightAnchor constraintEqualToConstant:FIGURE_SIZE],
        [trinagleView.widthAnchor constraintEqualToConstant:FIGURE_SIZE],
        [trinagleView.centerYAnchor constraintEqualToAnchor:_figuresView.centerYAnchor],
        [trinagleView.leftAnchor constraintEqualToAnchor:squareView.rightAnchor constant: 30],
    ]];
}

-(void)CVButtonTapped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://tutejsy.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

-(void)startButtonTapped {
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
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
