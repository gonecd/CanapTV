//
//  Aview.m
//  CanapTV
//
//  Created by Cyril Delamare on 28/12/2013.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "Aview.h"

@interface Aview ()

@end

@implementation Aview

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)affiche {
    [self.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(321, 0, 704, 768)];
    [UIView commitAnimations];
}




@end
