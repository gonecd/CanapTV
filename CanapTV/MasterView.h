//
//  MasterView.h
//  CanapTV
//
//  Created by Cyril Delamare on 01/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
#import "FilterView.h"

@interface MasterView : UIViewController <UISplitViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
    DetailView * detailVC;
    FilterView * filterVC;
    NSArray * categs;
}


@property (weak, nonatomic) IBOutlet UITextField *motCle;
@property (weak, nonatomic) IBOutlet UISwitch *titre;
@property (weak, nonatomic) IBOutlet UISwitch *sousTitre;
@property (weak, nonatomic) IBOutlet UISwitch *resume;
@property (weak, nonatomic) IBOutlet UIPickerView *categorie;
@property (weak, nonatomic) IBOutlet UISegmentedControl *source;
@property (weak, nonatomic) IBOutlet UISegmentedControl *jour;
@property (weak, nonatomic) IBOutlet UISegmentedControl *heure;

- (void) setCategories:(NSArray *)categories;
- (IBAction)filtrer:(id)sender;
- (IBAction)selectQuand:(id)sender;

- (IBAction)refresh:(id)sender;


@end
