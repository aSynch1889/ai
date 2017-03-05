//
//  ISVPlaySoundTool.m
//  ISV
//
//  Created by aaaa on 15/12/10.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVPlaySoundTool.h"

#define DISPOSE_INTERVAL 3

@implementation ISVPlaySoundTool

static ISVPlaySoundTool *instance = nil;

+ (ISVPlaySoundTool *)sharePlaySoundTool{
    
    //同步防止多线程访问,这里本来想用instance来作为锁对象的，但是当instance为nil的时候不能作为锁对象
    @synchronized(self){
        if (!instance) {
            instance= [[ISVPlaySoundTool alloc]init];
        }
    }
    return instance;
}

- (void)playingVibrate
{
    SystemSoundID soundID = kSystemSoundID_Vibrate;
    AudioServicesPlaySystemSound(soundID);
    [self performSelector:@selector(disposeSoundID:) withObject:[NSNumber numberWithLong:soundID] afterDelay:DISPOSE_INTERVAL];
}


/**
 *	@brief	播放系统声音
 *
 *	@return	self
 */
- (void)playingSystemSound:(SystemSoundID)soundId{
    
    //系统声音
    AudioServicesPlaySystemSound(soundId);
}

- (void)playingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    
    NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
    if (path) {
        SystemSoundID soundID;
        OSStatus error =  AudioServicesCreateSystemSoundID((__bridge  CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(soundID);
            [self performSelector:@selector(disposeSoundID:) withObject:[NSNumber numberWithLong:soundID] afterDelay:DISPOSE_INTERVAL];
        }else {
            NSLog(@"Failed to create sound ");
        }
    }
    
    
}

- (void)playingSoundEffectWith:(NSString *)filename
{
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    if (fileURL != nil)
    {
        SystemSoundID soundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge  CFURLRef)fileURL, &soundID);
        if (error == kAudioServicesNoError){
            AudioServicesPlaySystemSound(soundID);
            [self performSelector:@selector(disposeSoundID:) withObject:[NSNumber numberWithLong:soundID] afterDelay:DISPOSE_INTERVAL];
        }else {
            NSLog(@"Failed to create sound ");
        }
    }
    
}
//播放背景音乐,如停止，需根据SystemSoundID来
- (unsigned long)playingBgSoundEffectWith:(NSString *)filename{
    SystemSoundID soundID;
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    if (fileURL != nil)
    {
        
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge  CFURLRef)fileURL, &soundID);
        if (error == kAudioServicesNoError){
            AudioServicesPlaySystemSound(soundID);
        }else {
            NSLog(@"Failed to create sound ");
        }
    }
    return soundID;
}

-(void)disposeSoundID:(NSNumber *)soundID
{
    AudioServicesDisposeSystemSoundID(soundID.intValue);
}

@end
