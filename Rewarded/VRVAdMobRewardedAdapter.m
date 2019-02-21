//
//  VRVAdMobRewardedAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobRewardedAdapter.h"
#import "VRVAdMoBRewardedViewController.h"

@interface VRVAdMobRewardedAdapter ()

@property (nonatomic, weak) id<GADMRewardBasedVideoAdNetworkConnector> rewardBasedVideoAdConnector;
@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;
@property (nonatomic) VRVAdMoBRewardedViewController *adViewController;

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
        _adViewController = [[VRVAdMoBRewardedViewController alloc] initWithAdapter:self];
    }
    return self;
}

- (void)setUp {
    NSString *paramString = [self.rewardBasedVideoAdConnector.credentials objectForKey:@"TBD"];//GADCustomEventParametersServer];
    NSDictionary *params = [NSJSONSerialization JSONObjectWithData:[paramString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if([params objectForKey:@"appID"]) {
        self.appId = params[@"appID"];
    } else {
        [self.rewardBasedVideoAdConnector adapter:self didFailToSetUpRewardBasedVideoAdWithError:nil];
        NSLog(@"Please ensure that you have added an 'appID' in the AdMob Dashboard");
        return;
    }
    if([params objectForKey:@"zone"])  {
        self.zone = params[@"zone"];
    } else {
        NSLog(@"Please ensure that you have added a 'zone' in the AdMob Dashboard");
        [self.rewardBasedVideoAdConnector adapter:self didFailToSetUpRewardBasedVideoAdWithError:nil];
        return;
    }
    
    [self.rewardBasedVideoAdConnector adapterDidSetUpRewardBasedVideoAd:self];
    [VRVRewardedAd setRewardedAdDelegate:self.adViewController appID:self.appId];
}

- (void)requestRewardBasedVideoAd {
    if (self.zone) {
        [VRVRewardedAd loadRewardedAdForZone:self.zone];
    }
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if (self.zone && self.adLoaded) {
        [viewController presentViewController:self.adViewController animated:NO completion:^{
            [VRVRewardedAd showRewardedAdForZone:self.zone];
            [self.rewardBasedVideoAdConnector adapterDidOpenRewardBasedVideoAd:self];
            [self.rewardBasedVideoAdConnector adapterDidStartPlayingRewardBasedVideoAd:self];
        }];
    } else {
        NSLog(@"Verve SDK: Attempted to present rewarded ad before it was loaded");
    }
}

- (void)stopBeingDelegate {

}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

#pragma mark - VRVRewardedAdDelegate
- (void)rewardedAdClosedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapterDidCloseRewardBasedVideoAd:self];
    }
}

- (void)rewardedAdFailedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:nil];
    }
}

- (void)rewardedAdReadyForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapterDidReceiveRewardBasedVideoAd:self];
        self.adLoaded = YES;
    }
}

- (void)rewardedAdRewardedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.rewardBasedVideoAdConnector adapter:self didRewardUserWithReward:nil];
    }
}

@end
