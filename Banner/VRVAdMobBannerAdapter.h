//
//  VRVAdMobBannerAdapter.h
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerveAd/VRVBannerAdView.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdMobBannerAdapter : NSObject <GADCustomEventBanner, VRVBannerAdDelegate>

@end

NS_ASSUME_NONNULL_END
