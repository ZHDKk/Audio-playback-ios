//
//  ViewController.h
//  音频播放
//
//  Created by zh dk on 2017/8/31.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>
{
    UIButton *_btnPlay;
    UIButton  *_btnPause;
    UIButton *_btnStop;
    
    //播放进度
    UIProgressView *_musicProgress;
    //声音大小滑动条
    UISlider *_volumeSlider;
    //静音开关
    UISwitch *_volumeOn;
    //音频播放器对象
    AVAudioPlayer *_player;
    
    NSTimer *_timer;
}

@end

