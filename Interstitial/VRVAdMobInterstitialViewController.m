//
//  VRVAdMobInterstitialViewController.m
//  admobAdapter
//
//  Created by Sam Boyce on 2/5/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobInterstitialViewController.h"

@interface VRVAdMobInterstitialViewController ()

@property (nonatomic, weak) VRVAdMobInterstitialAdapter *adapter;

@end

@implementation VRVAdMobInterstitialViewController

- (instancetype)initWithAdapter:(VRVAdMobInterstitialAdapter *)adapter {
    self = [super init];
    if (self) {
        _adapter = adapter;
    }
    return self;
}

- (void)onInterstitialAdClosedForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter interstitialAdClosedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onInterstitialAdFailedForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter interstitialAdFailedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onInterstitialAdReadyForZone:(nonnull NSString *)zone {
    if (self.adapter) [self.adapter interstitialAdReadyForZone:zone];
}

@end
