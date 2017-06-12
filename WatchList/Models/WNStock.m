//
//  WNStock.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNStock.h"

@implementation WNStock


-(instancetype)initWithDictionary:(NSDictionary *)inStockData
{
    self = [super init];
    
    self.symbol = ([inStockData objectForKey:kSymbol]) ? [inStockData objectForKey:kSymbol] : @"";
    self.name = ([inStockData objectForKey:kName]) ? [inStockData objectForKey:kName] : @"";
    
    self.change = ([inStockData objectForKey:kChange]) ? [NSNumber numberWithFloat:[[inStockData objectForKey:kChange] floatValue]]: [NSNumber numberWithFloat:0.0];
    self.percentageChange = ([inStockData objectForKey:kPercentageChange]) ? [NSNumber numberWithFloat:[[inStockData objectForKey:kPercentageChange] floatValue]]: [NSNumber numberWithFloat:0.0];
    self.averageDailyVolume = ([inStockData objectForKey:kAverageDailyVolume]) ? [NSNumber numberWithLong:[[inStockData objectForKey:kAverageDailyVolume] longLongValue]] : [NSNumber numberWithLongLong:0];
    
    self.currency = [inStockData objectForKey:kCurrency];
    self.marketCapitalization = [inStockData objectForKey:kMarketCapitalization];
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", _symbol, _name];
}

@end


