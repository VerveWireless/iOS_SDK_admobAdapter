//
//  VRVAdMoBRewardedViewController.m
//  admobAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMoBRewardedViewController.h"
#import <verveSDK/VRVRewardedAd.h>

@interface VRVAdMoBRewardedViewController ()

@property (nonatomic, weak) VRVAdMobRewardedAdapter *adapter;

@end

@implementation VRVAdMoBRewardedViewController

- (instancetype)initWithAdapter:(VRVAdMobRewardedAdapter *)adapter {
    self = [super init];
    if (self) {
        _adapter = adapter;
    }
    return self;
}

- (void)onRewardedAdClosedForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter rewardedAdClosedForZone:zone];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRewardedAdFailedForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter rewardedAdFailedForZone:zone];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRewardedAdReadyForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter rewardedAdReadyForZone:zone];
}

- (void)onRewardedAdRewardedForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter rewardedAdRewardedForZone:zone];
}

@end
