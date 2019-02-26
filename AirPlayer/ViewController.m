//
//  ViewController.m
//  AirPlayer
//
//  Created by 贺一鸣 on 2019/2/25.
//  Copyright © 2019 贺一鸣. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AVPlayersViewController.h"
#import <AVKit/AVKit.h>

@interface ViewController ()<AVRoutePickerViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *MP_Player;
@property (nonatomic, strong) MPVolumeView *View_airplay;
@property (nonatomic, strong) UILabel *lab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"MPMoviePlayerController";
    
    NSURL* url = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    _MP_Player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.view addSubview:self.MP_Player.view];
    self.MP_Player.view.frame=CGRectMake(20, 100, 320, 220);
    
    [self.MP_Player prepareToPlay];
//    [_MP_Player play];
    
    _View_airplay = [[MPVolumeView alloc] initWithFrame:CGRectMake(20, 350, 30, 30)];
    _View_airplay.showsVolumeSlider = NO;
    _View_airplay.backgroundColor = UIColor.blueColor;
    [self.view addSubview:_View_airplay];
    
    if (@available(iOS 11.0, *)) {
        AVRoutePickerView * view = [[AVRoutePickerView alloc]initWithFrame:CGRectMake(100, 350, 30, 30)];
        //活跃状态颜色
        view.activeTintColor = [UIColor redColor];
        //设置代理
        view.delegate = self;
        [self.view addSubview:view];
    } else {
        // Fallback on earlier versions
    }
    
    UIButton *btn_AV = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, 320, 40)];
    [btn_AV setTitle:@"前往AVPlayerViewController" forState:UIControlStateNormal];
    [btn_AV setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn_AV addTarget:self action:@selector(btn_AV_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_AV];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 450, self.view.frame.size.width, 30)];
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

-(void)btn_AV_Click{
    AVPlayersViewController *av = [[AVPlayersViewController alloc]init];
    [self.navigationController pushViewController:av animated:YES];
}

@end
