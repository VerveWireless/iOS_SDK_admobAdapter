//
//  VRVAdMobBannerAdapter.m
//  admobAdapter
//
//  Created by Sam Boyce on 1/10/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdMobBannerAdapter.h"

@interface VRVAdMobBannerAdapter ()

@property (nonatomic) VRVBannerAdView *bannerAd;

@end

@implementation VRVAdMobBannerAdapter

@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    if (!serverParameter) {
        NSString *noZone =  @"Zone needs to be set as the Parameter for this Ad request";
        [self.delegate customEventBanner:self didFailAd:[self createErrorForReason:noZone]];
        return;
    }
    
    VRVBannerAdSize bannerAdSize = [self mapVRVBannerSizeToGADBannerSize:adSize];
    if (bannerAdSize != VRVBannerSizeNone) {
        self.bannerAd = [[VRVBannerAdView alloc] initWithDelegate:self bannerSize:bannerAdSize andRootVC:[UIViewController new]];
        [self.bannerAd loadAdForZone:serverParameter];
    } else {
        NSString *badSize = @"The specificied size for this banner is not supported by the Verve SDK";
        [self.delegate customEventBanner:self didFailAd:[self createErrorForReason:badSize]];
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
    [self.delegate customEventBannerWillLeaveApplication:self];
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd failedForZone:(nonnull NSString *)zone {
    NSString *adFailed = @"Ad Failed";
    [self.delegate customEventBanner:self didFailAd:[self createErrorForReason:adFailed]];
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd readyForZone:(nonnull NSString *)zone {
    if ([bannerAd isEqual:self.bannerAd]) {
        [self.delegate customEventBanner:self didReceiveAd:self.bannerAd];
    }
}

- (NSError *)createErrorForReason:(NSString *)errorDescription {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorDescription };
    return [NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:userInfo];
}

@end
