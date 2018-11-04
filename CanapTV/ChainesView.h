//
//  ChainesView.h
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"


@interface ChainesView : UITableViewController{
    
    NSArray *allChaines;
    DetailView * detailVC;
}

- (void) setChaines:(NSArray *)chaines;

- (IBAction)change:(id)sender;

@end
