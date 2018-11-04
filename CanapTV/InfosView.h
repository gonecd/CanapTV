//
//  InfosView.h
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface InfosView : UIViewController {
    
    DetailView * detailVC;
    
}

@property (weak, nonatomic) IBOutlet UILabel *debut;
@property (weak, nonatomic) IBOutlet UILabel *fin;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *nbchaines;

- (IBAction)recharger:(id)sender;

@end
