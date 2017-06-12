//
//  WNWatchListManager.h
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

// WNWatchlist Manager is responsible for fetching the watchlist details from the backend and creating the stock models from the json response.

#import <Foundation/Foundation.h>


typedef void (^WatchListResponse) (NSArray *watchList, NSError *error);

@interface WNWatchListManager : NSObject


- (void)fetchWatchList:(WatchListResponse)responseCallback;

@end
