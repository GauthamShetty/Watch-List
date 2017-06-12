//
//  WNNetworkManager.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNNetworkManager.h"
#import "WNConstants.h"

@implementation WNNetworkManager


-(void)makeGETRequest:(NSString *)inPath responceCallback:(NetworkResponse)responceCallback{
    
    NSString *url = inPath;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                       @"Content-Type"       : @"application/json"
                                                       };
        [sessionConfiguration setHTTPCookieStorage:[NSHTTPCookieStorage sharedHTTPCookieStorage]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                    responceCallback(data,response,error);
            }] resume];
}

@end
