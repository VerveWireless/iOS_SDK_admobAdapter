//
//  VRVAdapterHelper.m
//  admobAdapter
//
//  Created by Sam Boyce on 2/19/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVAdapterHelper.h"

@implementation VRVAdapterHelper

+ (NSDictionary *)createInitValuesFromServerParameter:(NSString *)serverParamter {
    NSError *jsonError;
    NSDictionary *params = [NSJSONSerialization JSONObjectWithData:[serverParamter dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"Error processing Server Parameter: %@", jsonError.localizedDescription);
        return nil;
    } else if(![params objectForKey:@"appID"]) {
        NSLog(@"Please ensure that you have added an 'appID' to the Server Parameter");
        return nil;
    } else if(![params objectForKey:@"zone"])  {
        NSLog(@"Please ensure that you have added a 'zone' to the Server Paramter");
        return nil;
    } else {
        return params;
    }
}

+ (NSError *)createErrorForReason:(NSString *)errorDescription {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorDescription };
    return [NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:userInfo];
}

@end
