//
//  VRVAdMobInterstitialAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobInterstitialAdapter.h"
#import "VRVAdMobInterstitialViewController.h"
#import "VRVAdapterHelper.h"

@interface VRVAdMobInterstitialAdapter ()

@property (nonatomic) VRVAdMobInterstitialViewController *adViewController;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;

@end

@implementation VRVAdMobInterstitialAdapter
@synthesize delegate;

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request {
    if (!serverParameter) {
        NSString *noZone = @"Zone and App ID needs to be set as the Parameter for this Ad request";
        [self.delegate customEventInterstitial:self didFailAd:[VRVAdapterHelper createErrorForReason:noZone]];
        return;
    }
    
    self.adViewController = [[VRVAdMobInterstitialViewController alloc] initWithAdapter:self];
    self.adLoaded = NO;
    
    NSDictionary *params = [VRVAdapterHelper createInitValuesFromServerParameter:serverParameter];
    if (params) {
        self.zone = params[@"zone"];
        [VRVInterstitialAd setInterstitialAdDelegate:self.adViewController appID:params[@"appID"]];
        [VRVInterstitialAd loadInterstitialAdForZone:self.zone];
    } else {
        NSString *paramError = @"Could not retrieve server parameters";
        [self.delegate customEventInterstitial:self didFailAd:[VRVAdapterHelper createErrorForReason:paramError]];
    }
}

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    if (self.zone && self.adLoaded) {
        [self.delegate customEventInterstitialWillPresent:self];
        [rootViewController presentViewController:self.adViewController animated:NO completion:^{
            [VRVInterstitialAd showInterstitialAdForZone:self.zone];
        }];
    } else {
        NSLog(@"Verve SDK: Attempted to present interstitial ad before it was loaded");
    }
}
         
- (void)interstitialAdClosedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.delegate customEventInterstitialWillDismiss:self];
        [self.delegate customEventInterstitialDidDismiss:self];
    }
}

- (void)interstitialAdFailedForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.delegate customEventInterstitial:self didFailAd:[VRVAdapterHelper createErrorForReason:@"Ad Load Failed"]];
    }
}

- (void)interstitialAdReadyForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.delegate customEventInterstitialDidReceiveAd:self];
        self.adLoaded = YES;
    }
}

@end
