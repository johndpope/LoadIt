//
//  LoadItUserDefaults.m
//  LoadIt
//
//  Created by Michael J Albanese on 6/10/16.
//  Copyright © 2016 WayFwonts.com. All rights reserved.
//

#import "LoadItUserDefaults.h"


NSString *kLoadItSoundFontChangedNotification = @"LoadItSoundFontsChanged";

static NSString *kSoundFontURLDefaultsKey = @"SoundFontURLDefaultsKey";
static NSString *kSoundFontPresetIDDefaultsKey = @"SoundFontPresetIDDefaultsKey";
static NSString *kSoundFontPresetNameDefaultsKey = @"SoundFontPresetNameDefaultsKey";

static dispatch_once_t once_token;
static LoadItUserDefaults *_instance;


@implementation LoadItUserDefaults

+ (instancetype) sharedInstance
{
    dispatch_once(&once_token, ^{
        if (_instance == nil) {
            _instance = [[LoadItUserDefaults alloc] init];
        }
    });
    
    return _instance;
    
}

- (void) storeSoundFontURL:(NSURL *)soundFontUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:soundFontUrl];
    [defaults setObject:data forKey:kSoundFontURLDefaultsKey];
    [defaults synchronize];
}

- (void) storeSoundFontPresetId:(NSInteger)presetId withName:(NSString *)presetName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@(presetId)];
    [defaults setObject:data forKey:kSoundFontPresetIDDefaultsKey];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:presetName];
    [defaults setObject:data forKey:kSoundFontPresetNameDefaultsKey];
    [defaults synchronize];
}

- (NSURL *) retrieveSoundFontURL
{
    NSURL *soundFontUrl;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kSoundFontURLDefaultsKey];
    if (data) {
        soundFontUrl = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return soundFontUrl;
}

- (NSInteger) retrievePresetId
{
    NSInteger presetId = -77;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kSoundFontPresetIDDefaultsKey];
    if (data) {
        NSNumber *n = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        presetId = n.integerValue;
    }
    
    return presetId;
}

- (NSString *) retrievePresetName
{
    NSString *presetName;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kSoundFontPresetNameDefaultsKey];
    if (data) {
        presetName = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return presetName;
}

- (void) clearSoundFontURL
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kSoundFontPresetNameDefaultsKey];
    [defaults synchronize];
}

- (void) clearPresetId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kSoundFontPresetIDDefaultsKey];
    [defaults synchronize];
}

- (void) clearPresetName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kSoundFontPresetNameDefaultsKey];
    [defaults synchronize];
}

- (void) clearAllDefaults
{
    [self clearSoundFontURL];
    [self clearPresetId];
    [self clearPresetName];
}

@end




