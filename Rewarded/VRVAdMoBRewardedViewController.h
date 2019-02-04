//
//  VRVAdMoBRewardedViewController.h
//  admobAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRVAdMobRewardedAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdMoBRewardedViewController : UIViewController <VRVRewardedAdDelegate>

- (instancetype)initWithAdapter:(VRVAdMobRewardedAdapter *)adapter;

@end

NS_ASSUME_NONNULL_END
