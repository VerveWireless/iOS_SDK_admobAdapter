//
//  VRVAdMobInterstitialAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobInterstitialAdapter.h"
#import "VRVAdMobInterstitialViewController.h"

@interface VRVAdMobInterstitialAdapter ()

@property (nonatomic) VRVAdMobInterstitialViewController *adViewController;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;

@end

@implementation VRVAdMobInterstitialAdapter
@synthesize delegate;

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request {
    if (!serverParameter) {
        NSString *noZone =  @"Zone needs to be set as the Parameter for this Ad request";
        [self.delegate customEventInterstitial:self didFailAd:[self createErrorForReason:noZone]];
        return;
    }
    
    self.adViewController = [[VRVAdMobInterstitialViewController alloc] initWithAdapter:self];
    self.adLoaded = NO;
    self.zone = serverParameter;
    [VRVInterstitialAd setInterstitialAdDelegate:self.adViewController];
    [VRVInterstitialAd loadInterstitialAdForZone:self.zone];
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
        [self.delegate customEventInterstitial:self didFailAd:[self createErrorForReason:@"Ad Load Failed"]];
    }
}

- (void)interstitialAdReadyForZone:(nonnull NSString *)zone {
    if ([self.zone isEqualToString:zone]) {
        [self.delegate customEventInterstitialDidReceiveAd:self];
        self.adLoaded = YES;
    }
}

- (NSError *)createErrorForReason:(NSString *)errorDescription {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorDescription };
    return [NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:userInfo];
}

@end
