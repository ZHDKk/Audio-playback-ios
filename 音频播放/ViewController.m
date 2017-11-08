//
//  ViewController.m
//  音频播放
//
//  Created by zh dk on 2017/8/31.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPlay.frame = CGRectMake(140, 100, 100, 40);
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    [_btnPlay addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    
    _btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPause.frame = CGRectMake(140, 160, 100, 40);
    [_btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [_btnPause addTarget:self action:@selector(pressPause) forControlEvents:UIControlEventTouchUpInside];
    
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnStop.frame = CGRectMake(140, 200, 100, 40);
    [_btnStop setTitle:@"停止" forState:UIControlStateNormal];
    [_btnStop addTarget:self action:@selector(pressStop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btnPlay];
    [self.view addSubview:_btnPause];
    [self.view addSubview:_btnStop];
    
    _musicProgress = [[UIProgressView alloc] init];
    _musicProgress.frame = CGRectMake(40, 300, 300, 20);
    _musicProgress.progress = 0;
    
    
    _volumeSlider = [[UISlider alloc] init];
    _volumeSlider.frame = CGRectMake(40, 380, 300, 20);
    _volumeSlider.maximumValue = 100;
    _volumeSlider.minimumValue = 0;
    [_volumeSlider addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_musicProgress];
    [self.view addSubview:_volumeSlider];
    
    [self createAVPlayer];
}

-(void)createAVPlayer
{
    //获取本地资源文件
    NSString *str= [[NSBundle mainBundle]pathForResource:@"001" ofType:@"mp3"];
    //将字符串转换成url
    NSURL *urlMusic = [NSURL fileURLWithPath:str];
    //创建音频播放器对象
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMusic error:nil];
    
    //准备播放，解码工作
    [_player prepareToPlay];
    //循环播放的次数。 -1表示无限循环
    _player.numberOfLoops = -1;
    
    //创建一个定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateT) userInfo:nil repeats:YES];
    
    
    _player.delegate = self;
    
}

//当音乐播放完成时调用
-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_timer invalidate];
}

-(void)updateT
{
    _musicProgress.progress = _player.currentTime/_player.duration;
}
-(void) pressPlay
{
    NSLog(@"播放音乐");
    [_player play];
    _volumeSlider.value = 100;

}
-(void) pressPause
{
    NSLog(@"暂停音乐");
    [_player pause];
}
-(void)pressStop
{
    NSLog(@"停止音乐");
    [_player stop];
    _player.currentTime = 0;
    _volumeSlider.value = 0;
}
-(void)volumeChange:(UISlider*)slider
{
    
    NSLog(@"%f",slider.value);
    //设置音量大小
    _player.volume = slider.value/100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
