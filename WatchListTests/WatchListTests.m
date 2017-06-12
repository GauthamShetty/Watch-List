//
//  WatchListTests.m
//  WatchListTests
//
//  Created by Gautham S Shetty on 6/11/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WNWatchListManager.h"

@interface WatchListTests : XCTestCase
@property WNWatchListManager *watchListManager;
@property XCTestExpectation *expectation;
@end

@implementation WatchListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    _watchListManager = [[WNWatchListManager alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) testNumberOfStock {
    
    _expectation = [self expectationWithDescription:@"loadWatchList"];
    
    __block NSArray *stockList;
    
    [self.watchListManager fetchWatchList:^(NSArray *watchList, NSError *error){
        [_expectation fulfill];
        stockList = watchList;
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    int count = (int)stockList.count;
    XCTAssertEqual(count, 6, @"All the stock data are not received");

}

@end
