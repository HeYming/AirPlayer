//
//  ManageMPViewController.m
//  AirPlayer
//
//  Created by 贺一鸣 on 2019/2/26.
//  Copyright © 2019 贺一鸣. All rights reserved.
//

#import "ManageMPViewController.h"
#import "MYCAirplayManager.h"

@interface ManageMPViewController ()<MYCAirplayManagerDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation ManageMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"手动管理AirPlay";
    
    [MYCAirplayManager sharedManager].delegate = self;
    
    CGFloat width = 100;
    CGFloat height = 30;
    CGFloat x1 = 40;
    CGFloat x2 = 150;
    CGFloat y1 = 40;
    CGFloat interval = 30;
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(x1, y1 + interval, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"查找设备" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x1, (y1 + interval) *  2, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"连接设备" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(activateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x2, (y1 + interval) *  2, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"断开设备" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeSocketButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x1, (y1 + interval) *  3,width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"开始播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x2, (y1 + interval) *  3, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"退出播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(stopButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x2, (y1 + interval) *  4, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"继续播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x1, (y1 + interval) *  4, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"暂停" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [[UIButton alloc]init];
    button.frame = CGRectMake(x1, (y1 + interval) *  5, width,height);
    button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"快进" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(progressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 370, self.view.frame.size.width, 60)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
}

-(void)searchButtonClick
{
    [[MYCAirplayManager sharedManager] searchAirplayDeviceWithTimeOut:15];
}

-(void)activateButtonClick
{
    [[MYCAirplayManager sharedManager] activateSocketToDevice:[MYCAirplayManager sharedManager].deviceList.firstObject];
}

-(void)closeSocketButtonClick
{
    [[MYCAirplayManager sharedManager] closeSocket];
}

-(void)startButtonClick
{
    [[MYCAirplayManager sharedManager] playVideoOnAirplayDevice:[MYCAirplayManager sharedManager].deviceList.firstObject videoUrlStr:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
}


-(void)progressButtonClick
{
    [[MYCAirplayManager sharedManager] seekPlayTime:5.0];
}

-(void)pauseButtonClick
{
    [[MYCAirplayManager sharedManager] pauseVideoPlay];
}

-(void)playButtonClick
{
    [[MYCAirplayManager sharedManager] playVideo];
}



-(void)stopButtonClick
{
    [[MYCAirplayManager sharedManager] stop];
}

#pragma mark -- MYCAirplayManagerDelegate

- (void)MYCAirplayManager:(MYCAirplayManager *)airplayManager searchedAirplayDevice:(NSMutableArray<MYCAirplayDevice *> *)deviceList
{
    _label.text = [NSString stringWithFormat:@"已经获取到设备列表，总数%lu",(unsigned long)deviceList.count];
}

-(void)MYCAirplayManager:(MYCAirplayManager *)airplayManager searchAirplayDeviceFinish:(NSMutableArray<MYCAirplayDevice *> *)deviceList
{
    _label.text = @"搜索设备操作完成";
}

-(void)MYCAirplayManager:(MYCAirplayManager *)airplayManager selectedDeviceOnLine:(MYCAirplayDevice *)airplayDevice
{
    _label.text = [NSString stringWithFormat:@"设备已连接---%@",airplayDevice.displayName];
}

- (void)MYCAirplayManager:(MYCAirplayManager *)airplayManager selectedDeviceDisconnect:(MYCAirplayDevice *)airplayDevice
{
    _label.text = [NSString stringWithFormat:@"设备已断开---%@",airplayDevice.displayName];
}

@end
