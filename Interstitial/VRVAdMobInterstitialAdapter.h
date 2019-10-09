//
//  VRVAdMobInterstitialAdapter.h
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerveAd/VRVInterstitialAd.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdMobInterstitialAdapter : NSObject <GADCustomEventInterstitial>

- (void)interstitialAdClosedForZone:(nonnull NSString *)zone;
- (void)interstitialAdFailedForZone:(nonnull NSString *)zone;
- (void)interstitialAdReadyForZone:(nonnull NSString *)zone;

@end

NS_ASSUME_NONNULL_END
