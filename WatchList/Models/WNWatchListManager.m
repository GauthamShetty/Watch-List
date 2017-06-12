//
//  WNWatchListManager.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNWatchListManager.h"
#import "WNStock.h"
#import "WNNetworkManager.h"


NSString *kwatchListPath = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22AAPL%22,%20%22FB%22,%20%22GOOGL%22,%20%22TWTR%22,%20%22YHOO%22,%20%22MSFT%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
NSString *kQuote = @"quote";
NSString *kQuery = @"query";
NSString *kResults = @"results";

@interface WNWatchListManager ()

@property (nonatomic, strong) WNNetworkManager *networkMngr;

@end

@implementation WNWatchListManager

-(WNNetworkManager *)networkMngr
{
    if(!_networkMngr)
    {
        _networkMngr = [[WNNetworkManager alloc] init];
    }
    return _networkMngr;
}

- (void)fetchWatchList:(WatchListResponse)responseCallback
{
    [self.networkMngr makeGETRequest:kwatchListPath responceCallback:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSError *jsonParsingError = nil;
        NSMutableArray *resultList = [NSMutableArray array];

        if (data) {
            NSMutableDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            if (responseData) {
                NSArray *quotesList = [[[responseData objectForKey:kQuery] objectForKey:kResults] objectForKey:kQuote];
                
                for (int i = 0; i < [quotesList count]; i++) {
                    WNStock *stock = [[WNStock alloc] initWithDictionary:[quotesList objectAtIndex:i]];
                    [resultList addObject:stock];
                }
            }
            else{
                
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: NSLocalizedStringFromTable(@"Request_Invalid", @"WNLocalizable", @"Request Invalid"),
                                           NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(@"Request_Invalid_Reason", @"WNLocalizable", @"Request Invalid Reason")  };
                error = [NSError errorWithDomain:@"WNErrorDomain"
                                                     code:-43
                                                 userInfo:userInfo];
            }
        }
        responseCallback(resultList,error);
        
    }];
    
}

@end
