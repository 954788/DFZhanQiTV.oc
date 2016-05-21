//
//  TvViewController.m
//  DFZhanQiTv.oc
//
//  Created by 梁粱展焯 on 16/4/21.
//  Copyright © 2016年 粱展焯. All rights reserved.
//

#import "TvViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+SDAutoLayout.h"



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TvViewController ()

@property (strong, nonatomic) UIView *playView;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVPlayerItem *item;
@property (strong, nonatomic) UIToolbar *toolbar;

@end

@implementation TvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"直播";
    
    //    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    //[self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    
    //---PlayView---
    _playView = [[UIView alloc]init];
    _playView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
    [self.view addSubview:_playView];
    
    //---AVPlayerItem---
    _item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_urlString]];
    self.player = [[AVPlayer alloc]initWithPlayerItem:_item];
    
    //---AVPlayerLayer---
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playView.layer addSublayer:_playerLayer];
    
    [self.player play];
    
    //---重连按钮---
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"重连" style:UIBarButtonItemStylePlain target:self action:@selector(repeat)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showToolView)];
    [self.playView addGestureRecognizer:tap];
    
    //---工具条---
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, _playView.frame.size.height-40, _playView.frame.size.width, 40)];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        button.backgroundColor = [UIColor grayColor];
        
        [button addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        NSMutableArray *array = [NSMutableArray array];
        
        [array addObject:item];
        
        _toolbar.items = array;
        
        [_playView addSubview:_toolbar];
    }
    
    _toolbar.hidden = YES;
    _toolbar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 转屏
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.interfaceOrientation == UIDeviceOrientationPortrait) {
        NSLog(@"竖直");
        
         _toolbar.hidden = YES;
        
        _playView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
        
        _toolbar.frame = CGRectMake(0, _playView.frame.size.height-40, _playView.frame.size.width, 40);
        
        _playerLayer.frame = CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height);
        
        [self.navigationController setNavigationBarHidden:NO];
        
    } else if (self.interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"水平向左");
        
         _toolbar.hidden = YES;
        
        _playView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _toolbar.frame = CGRectMake(0, _playView.frame.size.height-40, _playView.frame.size.width, 40);
        
        _playerLayer.frame = CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height);
        
        [self.navigationController setNavigationBarHidden:YES];
    } else if(self.interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        NSLog(@"水平向右");
        
         _toolbar.hidden = YES;
        
        _playView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _toolbar.frame = CGRectMake(0, _playView.frame.size.height-40, _playView.frame.size.width, 40);
        
        _playerLayer.frame = CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height);
        
        [self.navigationController setNavigationBarHidden:YES];
    }
    
   
    
}

#pragma mark - 点击事件
#pragma mark 重连
-(void)repeat{
    _item = nil;
    _player = nil;
    [_playerLayer removeFromSuperlayer];
    
    _item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:_urlString]];
    
    self.player = [[AVPlayer alloc]initWithPlayerItem:_item];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    _playerLayer.frame = CGRectMake(0, 0, _playView.frame.size.width, _playView.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.playView.layer addSublayer:_playerLayer];
    _playerLayer.zPosition = 10;
    _toolbar.layer.zPosition = 11;
    
    [self.player play];
}

#pragma mark 工具条
-(void)showToolView{
    
    if (_toolbar.hidden) {
        _toolbar.hidden = NO;
    }else{
        _toolbar.hidden = YES;
    }
    
    
}

#pragma mark 暂停
-(void)pauseAction{
    [_player pause];
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
