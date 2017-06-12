//
//  WNUtilities.h
//  WatchList
//
//  Created by Gautham S Shetty on 6/12/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNUtilities : NSObject


+ (void) showAlertForError : (NSError *)error onController:(UIViewController *)inController;
@end
