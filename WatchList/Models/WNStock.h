//
//  WNStock.h
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import <Foundation/Foundation.h>

// string macros for the keys of the value to be consumed for Symbol data

#define kSymbol @"Symbol"
#define kName @"Name"
#define kChange @"Change"
#define kPercentageChange @"PercentChange"
#define kCurrency @"Currency"
#define kAverageDailyVolume @"AverageDailyVolume"
#define kMarketCapitalization @"MarketCapitalization"

@interface WNStock : NSObject

@property(nonatomic,strong)NSString *symbol;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *change;
@property(nonatomic,strong)NSNumber *percentageChange;
@property(nonatomic,strong)NSString *currency;
@property(nonatomic,strong)NSNumber *averageDailyVolume;
@property(nonatomic,strong)NSString *marketCapitalization;

-(instancetype)initWithDictionary:(NSDictionary *)inStockData;

@end


