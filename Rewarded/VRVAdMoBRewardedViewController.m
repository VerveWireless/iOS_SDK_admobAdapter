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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onRewardedAdClosedForZone:(nonnull NSString *)zone {
    [self.adapter rewardedAdClosedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onRewardedAdFailedForZone:(nonnull NSString *)zone {
    [self.adapter rewardedAdFailedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onRewardedAdReadyForZone:(nonnull NSString *)zone {
    [self.adapter rewardedAdReadyForZone:zone];
}

- (void)onRewardedAdRewardedForZone:(nonnull NSString *)zone {
    [self.adapter rewardedAdRewardedForZone:zone];
}

@end
