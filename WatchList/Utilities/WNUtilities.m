//
//  WNUtilities.m
//  WatchList
//
//  Created by Gautham S Shetty on 6/12/17.
//  Copyright © 2017 Gautham S Shetty. All rights reserved.
//

#import "WNUtilities.h"

@implementation WNUtilities



+ (void) showAlertForError : (NSError *)error onController:(UIViewController *)inController
{
    
    NSDictionary *userInfo = error.userInfo;
    
    NSString *titleStr = error.localizedDescription;
    NSString *messageStr = error.localizedFailureReason;
    // Check if user created error condition exists if so display that else use the default descriptions.
    if(userInfo && [userInfo objectForKey:@"NSLocalizedDescriptionKey"])
    {
        titleStr = [userInfo objectForKey:@"NSLocalizedDescriptionKey"];
        messageStr = [userInfo objectForKey:@"NSLocalizedFailureReason"];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(inController && [inController isKindOfClass:[UIViewController class]])
        [inController presentViewController:alertController animated:YES completion:nil];
    });
    
    
}

@end
