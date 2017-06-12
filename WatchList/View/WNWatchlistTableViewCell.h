//
//  WNWatchlistTableViewCell.h
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNStock.h"
#import "WNConstants.h"

@protocol WNWatchlistTableViewCellDelegate;

@interface WNWatchlistTableViewCell : UITableViewCell

@property (nonatomic, strong) WNStock *stock;
@property (nonatomic, weak) IBOutlet UILabel *lblSlNo;
@property (nonatomic, weak) NSObject <WNWatchlistTableViewCellDelegate> *delegate;
@end

@protocol WNWatchlistTableViewCellDelegate <NSObject>
-(void)didTapSymbolInCell:(WNWatchlistTableViewCell *)inCell;
@end
