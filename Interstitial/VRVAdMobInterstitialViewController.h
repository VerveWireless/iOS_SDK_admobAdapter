//
//  VRVAdMobInterstitialViewController.h
//  admobAdapter
//
//  Created by Sam Boyce on 2/5/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRVAdMobInterstitialAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdMobInterstitialViewController : UIViewController <VRVInterstitialAdDelegate>

- (instancetype)initWithAdapter:(VRVAdMobInterstitialAdapter *)adapter;

@end

NS_ASSUME_NONNULL_END
