//
//  VRVAdMobRewardedAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobRewardedAdapter.h"
#import <verveSDK/VRVFSAdHandler.h>

@interface VRVAdMobRewardedAdapter () <VRVFSAdDelegate>

@property (nonatomic, weak) id<GADMRewardBasedVideoAdNetworkConnector> rewardBasedVideoAdConnector;
@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;

@end

@implementation VRVAdMobRewardedAdapter

+ (NSString *)adapterVersion {
    return nil;
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _rewardBasedVideoAdConnector = connector;
        _appId = @"";
        _zone = @"";
        _adLoaded = NO;
    }
    return self;
}

- (void)setUp {
    NSString *paramString = [self.rewardBasedVideoAdConnector.credentials objectForKey:GADCustomEventParametersServer];
    NSDictionary *params = [NSJSONSerialization JSONObjectWithData:[paramString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if([params objectForKey:@"appID"]) {
        self.appId = params[@"appID"];
    } else {
        [self.rewardBasedVideoAdConnector adapter:self didFailToSetUpRewardBasedVideoAdWithError:nil];
        NSLog(@"Please ensure that you have added appID in the AdMob Dashboard");
        return;
    }
    if([params objectForKey:@"zone"])  {
        self.zone = params[@"zone"];
    } else {
        NSLog(@"Please ensure that you have added zone in the AdMob Dashboard");
        [self.rewardBasedVideoAdConnector adapter:self didFailToSetUpRewardBasedVideoAdWithError:nil];
        return;
    }
    
    [self.rewardBasedVideoAdConnector adapterDidSetUpRewardBasedVideoAd:self];
    [[VRVFSAdHandler sharedHandler] setFSAdDelegate:self];
}

- (void)requestRewardBasedVideoAd {
    if (self.zone) {
        [[VRVFSAdHandler sharedHandler] loadFSAdForZone:self.zone];
    }
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if (self.zone) {
        [[VRVFSAdHandler sharedHandler] showFSAdForZone:self.zone inViewController:viewController];
        if (self.adLoaded) {
            [self.rewardBasedVideoAdConnector adapterDidOpenRewardBasedVideoAd:self];
            [self.rewardBasedVideoAdConnector adapterDidStartPlayingRewardBasedVideoAd:self];
        }
    }
}

- (void)stopBeingDelegate {

}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

#pragma mark - VRVFSAdDelegate

- (void)onFSAdClosedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:self];
    }
}

- (void)onFSAdFailedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:nil];
    }
}

- (void)onFSAdReadyForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:self];
        self.adLoaded = YES;
    }
}

- (void)onFSAdRewardedForZone:(NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapter:self didRewardUserWithReward:nil];
    }
}

@end
