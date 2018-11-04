//
//  ChainesView.m
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "ChainesView.h"
#import "Chaine.h"

@interface ChainesView ()

@end

@implementation ChainesView

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    detailVC = [[DetailView alloc] init];
    detailVC = [[[self splitViewController] viewControllers] objectAtIndex:1];
    
    allChaines = [[NSArray alloc] init];
    allChaines = [detailVC getChaines];
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allChaines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[allChaines objectAtIndex:indexPath.row] nom] ];
    NSString *path = [[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/logos/"] stringByAppendingString:[[allChaines objectAtIndex:indexPath.row] logo]];
    cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:path];
    
    return cell;
} 

- (void) setChaines:(NSArray *)chaines {
    allChaines = chaines;
}

- (IBAction)change:(id)sender {
    [detailVC afficheChaines];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [detailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(chaine == %@)", [[allChaines objectAtIndex:indexPath.row] nom] ] pourDeVrai:YES];
}

@end
