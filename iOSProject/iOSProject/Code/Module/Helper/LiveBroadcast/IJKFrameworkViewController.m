//
//  IJKFrameworkViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/8.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import "IJKFrameworkViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface IJKFrameworkViewController ()

@property (nonatomic, strong) NSURL * url;
@property (nonatomic, strong) id<IJKMediaPlayback> player;
@property (nonatomic, strong) UIView * playerView;

@end

@implementation IJKFrameworkViewController


#pragma mark - Override Methods
-(void)dealloc {
    
    [self removeMovieNotificationObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:@"http://221.228.226.23/11/t/j/v/b/tjvbwspwhqdmgouolposcsfafpedmb/sh.yinyuetai.com/691201536EE4912BF7E4F1E2C67B8119.mp4"];
    // self.url = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL: self.url withOptions: nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * play = [self.player view];
    
    UIView * displayView = [[UIView alloc] initWithFrame: CGRectMake(0, 64, self.view.bounds.size.width, 180)];
    self.playerView = displayView;
    self.playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview: self.playerView];
    
    play.frame = self.playerView.bounds;
    //属性的意思就是自动调整子控件与父控件中间的位置，宽高
    play.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.playerView insertSubview: play atIndex: 1];
    
    [_player setScalingMode: IJKMPMovieScalingModeAspectFill];
    [self installMovieNotificationObservers];
    
    
    UIButton * button = [UIButton new];
    [button setTitle:@"暂停" forState: UIControlStateNormal];
    button.tag = 200;
    [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blackColor];
    button.frame = CGRectMake(100, 300, 200, 45);
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget: self action: @selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if (![self.player isPlaying]) {
    }else{
        [self.player pause];
    }
    [self.player stop];
    self.player = nil;
}

#pragma mark - Public Methods


#pragma mark - Events
- (void)buttonAction:(UIButton *)sender {
    if (![self.player isPlaying]) {
        [sender setTitle:@"暂停" forState: UIControlStateNormal];
        [self.player play];
    }else{
        [sender setTitle:@"开始" forState: UIControlStateNormal];
        [self.player pause];
    }
}

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification  {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}


- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

#pragma mark - Private Methods
//Install Notifiacation

- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadStateDidChange:) name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object: _player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark - Extension Delegate or Protocol
- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}
@end








