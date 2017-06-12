//
//  WNWatchListViewController.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/9/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNWatchListViewController.h"
#import "WNWatchListManager.h"
#import "WNStock.h"
#import "WNWatchlistTableViewCell.h"
#import "WNUtilities.h"
#import "MBProgressHUD.h"


@interface WNWatchListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *watchListView;
@property (nonatomic, strong) WNWatchListManager *watchlistManager;
@property (nonatomic, strong) NSArray *watchList;

@end

@implementation WNWatchListViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [ self loadWatchList];

}

-(WNWatchListManager *)watchlistManager
{
    if (!_watchlistManager) {
        _watchlistManager = [[WNWatchListManager alloc] init];
    }
    return _watchlistManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadWatchList
{
    //Fetch the watchlist and reload the list view.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    __weak WNWatchListViewController *weakSelf = self;
    
    [self.watchlistManager fetchWatchList:^(NSArray *watchList, NSError *error)
     {
         if(error)
         {
             [WNUtilities showAlertForError:error onController:self];
         }
         else
         {
             weakSelf.watchList = watchList;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [_watchListView reloadData];
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

             });
         }
     }];
}

-(IBAction)performTableviewColumnSort:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSString *title = @"";
    
    switch (button.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            title = @"symbol";
        }
            break;
        case 2:
        {
            title = @"name";
        }
            break;
        case 3:
        {
            title = @"change";
        }
            break;
        case 4:
        {
            title = @"percentageChange";
        }
            break;
        case 5:
        {
            title = @"currency";
        }
            break;
        case 6:
        {
            title = @"averageDailyVolume";
        }
            break;
            
        default:
            break;
    }
    
    [self sortByTitle:title];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_watchListView reloadData];
    });
}


// To sort the datasource based on the stock parameters. In case sorting is needed on tapping the tableview headers.
- (void) sortByTitle:(NSString *)inTitle
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:inTitle ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.watchList = [_watchList sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma TableView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_watchList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WNWatchlistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"watchListCell"];
    cell.backgroundColor = (indexPath.row % 2) ? [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0] : [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    cell.lblSlNo.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.stock = [_watchList objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setNeedsDisplay];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma WNWatchlistTableViewCellDelegate Method implementation
-(void)didTapSymbolInCell:(WNWatchlistTableViewCell *)inCell
{
    NSIndexPath *indexPath = [_watchListView indexPathForCell:inCell];
    WNStock *stock = [_watchList objectAtIndex:indexPath.row];
    
    NSString *message = [NSString stringWithFormat:NSLocalizedStringFromTable(@"Market_Capitalization_Alert_Message", @"WNLocalizable", @"Market Capitalization is: %@"), stock.marketCapitalization];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:stock.name message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
