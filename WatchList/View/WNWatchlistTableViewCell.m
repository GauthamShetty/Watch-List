//
//  WNWatchlistTableViewCell.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/10/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNWatchlistTableViewCell.h"

@interface WNWatchlistTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *lblSymbol;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UILabel *lblPriceChange;
@property (nonatomic, weak) IBOutlet UILabel *lblPricePercentageChange;
@property (nonatomic, weak) IBOutlet UILabel *lblTradingCurrency;
@property (nonatomic, weak) IBOutlet UILabel *lblAvgDailyVol;
@end

@implementation WNWatchlistTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(symbolTapped:)];
//    tapGesture.numberOfTapsRequired=1;
//    [_lblSymbol addGestureRecognizer:tapGesture];
    
    
    UIButton *actionHandler = [[UIButton alloc] initWithFrame:_lblSymbol.frame];
    [actionHandler addTarget:self action:@selector(symbolTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionHandler];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)symbolTapped:(UIGestureRecognizer *)inGesture
- (void)symbolTapped:(id )sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didTapSymbolInCell:)]) {
        [_delegate didTapSymbolInCell:self];
    }
}
- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];

}
- (void) setStock:(WNStock *)inStock
{
    _stock =inStock;
    if (_stock) {
        _lblName.text =  _stock.name;
        _lblSymbol.text = _stock.symbol ;
        
        _lblPriceChange.text = [NSString stringWithFormat:@"%.2f",[_stock.change floatValue]] ;
        _lblPricePercentageChange.text = [NSString stringWithFormat:@"%.2f",[_stock.percentageChange floatValue]] ;
        _lblTradingCurrency.text = _stock.currency;
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setCurrencySymbol:@""];
        
        NSString *numberAsString = [numberFormatter stringFromNumber:_stock.averageDailyVolume];
        _lblAvgDailyVol.text = numberAsString;
        
        
        // Set the text color to indicate the positive and negative value.
        _lblPriceChange.textColor = ([_stock.change floatValue] < 0.0) ? WATCHLIST_CELL_NEG_COLOR : WATCHLIST_CELL_POS_COLOR;
        _lblPricePercentageChange.textColor = ([_stock.percentageChange floatValue] < 0.0) ?  WATCHLIST_CELL_NEG_COLOR: WATCHLIST_CELL_POS_COLOR;
        
    }

}
@end
