//
//  VRVAdMobRewardedAdapter.h
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerveAd/VRVRewardedAd.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdMobRewardedAdapter : NSObject <GADMRewardBasedVideoAdNetworkAdapter>

- (void)rewardedAdClosedForZone:(nonnull NSString *)zone;
- (void)rewardedAdFailedForZone:(nonnull NSString *)zone;
- (void)rewardedAdReadyForZone:(nonnull NSString *)zone;
- (void)rewardedAdRewardedForZone:(nonnull NSString *)zone;

@end

NS_ASSUME_NONNULL_END
