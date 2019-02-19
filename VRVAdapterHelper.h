//
//  VRVAdapterHelper.h
//  admobAdapter
//
//  Created by Sam Boyce on 2/19/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VRVAdapterHelper : NSObject

+ (NSDictionary * _Nullable)createInitValuesFromServerParameter:(NSString *)serverParamter;
+ (NSError *)createErrorForReason:(NSString *)errorDescription;

@end

NS_ASSUME_NONNULL_END
