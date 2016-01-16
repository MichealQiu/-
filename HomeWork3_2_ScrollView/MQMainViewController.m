//
//  MQMainViewController.m
//  HomeWork3_2_ScrollView
//
//  Created by Michael Qiu on 16/1/16.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

#import "MQMainViewController.h"
#import "MQPageView.h"

@interface MQMainViewController ()

@property (nonatomic, strong) MQPageView *pageView;

@end

@implementation MQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

    MQPageView *pageView = [MQPageView pageView];
    
    CGFloat pageViewW = 300;
    CGFloat pageViewH = 160;
    CGFloat pageViewX = (self.view.bounds.size.width - pageViewW) / 2;
    CGFloat pageViewY = 50;

    pageView.frame = CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH);
    pageView.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    pageView.otherColor = [UIColor grayColor];
    pageView.currentColor = [UIColor orangeColor];
    [self.view addSubview:pageView];
    self.pageView = pageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
