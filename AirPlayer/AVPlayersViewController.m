//
//  AVPlayersViewController.m
//  AirPlayer
//
//  Created by 贺一鸣 on 2019/2/25.
//  Copyright © 2019 贺一鸣. All rights reserved.
//

#import "AVPlayersViewController.h"
#import <AVKit/AVKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "ManageMPViewController.h"

@interface AVPlayersViewController ()<AVRoutePickerViewDelegate>
@property (nonatomic, strong) AVPlayerViewController *PlayerVC;
@property (nonatomic, strong) MPVolumeView *View_airplay;
@property (nonatomic, strong) UILabel *lab;
@end

@implementation AVPlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"AVPlayerViewController";
    
    _PlayerVC = [[AVPlayerViewController alloc] init];
    NSURL * url = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    _PlayerVC.player = [AVPlayer playerWithURL:url];
    _PlayerVC.view.frame = CGRectMake(20, 100, 300, 200);
    _PlayerVC.showsPlaybackControls = YES;
    [self.view addSubview:_PlayerVC.view];
//    [self.PlayerVC.player play];
    
    _View_airplay = [[MPVolumeView alloc] initWithFrame:CGRectMake(20, 320, 30, 30)];
    _View_airplay.showsVolumeSlider = NO;
    _View_airplay.backgroundColor = UIColor.blueColor;
    [self.view addSubview:_View_airplay];
    
    if (@available(iOS 11.0, *)) {
        AVRoutePickerView * view = [[AVRoutePickerView alloc]initWithFrame:CGRectMake(100, 320, 30, 30)];
        //活跃状态颜色
        view.activeTintColor = [UIColor redColor];
        //设置代理
        view.delegate = self;
        [self.view addSubview:view];
    } else {
        // Fallback on earlier versions
    }
    
    UIButton *btn_AV = [[UIButton alloc]initWithFrame:CGRectMake(20, 360, 320, 40)];
    [btn_AV setTitle:@"前往手动管理AirPlay" forState:UIControlStateNormal];
    [btn_AV setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn_AV addTarget:self action:@selector(btn_Manage_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_AV];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 30)];
    _lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lab];
}

//AirPlay界面弹出时回调
- (void)routePickerViewWillBeginPresentingRoutes:(AVRoutePickerView *)routePickerView API_AVAILABLE(ios(11.0)){
    _lab.text = @"AirPlay界面弹出时回调";
}
//AirPlay界面结束时回调
- (void)routePickerViewDidEndPresentingRoutes:(AVRoutePickerView *)routePickerView API_AVAILABLE(ios(11.0)){
    _lab.text = @"AirPlay界面结束时回调";
}

-(void)btn_Manage_Click{
    ManageMPViewController *ma = [[ManageMPViewController alloc]init];
    [self.navigationController pushViewController:ma animated:YES];
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
