//
//  VRVAdMobBannerAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobBannerAdapter.h"

@implementation VRVAdMobBannerAdapter

@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    
    VRVBannerAdSize bannerAdSize = [self mapVRVBannerSizeToGADBannerSize:adSize];
    if (bannerAdSize != VRVBannerSizeNone) {
        VRVBannerAdView *bannerAd = [[VRVBannerAdView alloc] initWithDelegate:self bannerSize:bannerAdSize andRootVC:[UIViewController new]];
    }
}

- (VRVBannerAdSize)mapVRVBannerSizeToGADBannerSize:(GADAdSize)size {
    CGFloat width = size.size.width;
    CGFloat height = size.size.height;
    
    if (width == 320 && height == 50) {
        return VRVBannerSizeBanner;
    } else if (width == 728 && height == 90) {
        return VRVBannerSizeTabletBanner;
    } else if (width == 300 && height == 250) {
        return VRVBannerSizeMedRectangle;
    } else {
        return VRVBannerSizeNone;
    }
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd closedForZone:(nonnull NSString *)zone {
    
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd failedForZone:(nonnull NSString *)zone {
    
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd readyForZone:(nonnull NSString *)zone {
    
}

@end
