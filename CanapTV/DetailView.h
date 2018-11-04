//
//  DetailView.h
//  CanapTV
//
//  Created by Cyril Delamare on 01/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgView.h"
#import "ChainesChooser.h"
#import "Aview.h"

@interface DetailView : UITableViewController {
    
    NSMutableArray *allProgs;
    NSArray *progs;
    
    ProgView * progVC;
    ChainesChooser * chainesChooser;
    //Aview * chainesChooser;
}

@property (strong, nonatomic) IBOutlet UITableView *table;

    -(void) afficheChaines;

    - (NSDate *) debut;
    - (NSDate *) fin;
    - (NSInteger) nombre;
    - (NSArray *) getCategories;
    - (NSArray *) getChaines;
    - (NSInteger) appliquerFiltre:(NSPredicate *)predicat pourDeVrai:(BOOL)vraiment;

    - (IBAction)triDate:(id)sender;
    - (IBAction)triChaine:(id)sender;

@end
