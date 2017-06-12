//
//  WNNetworkManager.h
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkResponse) (NSData *data, NSURLResponse *response, NSError *error);


@interface WNNetworkManager : NSObject

@property(nonatomic,strong)NSURLSession *sessionObject;

-(void)makeGETRequest:(NSString *)inPath responceCallback:(NetworkResponse)responceCallback;

@end
