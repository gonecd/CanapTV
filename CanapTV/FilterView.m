//
//  FilterView.m
//  CanapTV
//
//  Created by Cyril Delamare on 07/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "FilterView.h"
#import "myFilter.h"
#import "Filtre.h"

@interface FilterView ()

@end

@implementation FilterView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialisation des variables
	allFiltres = [[NSMutableArray alloc] init];
    allFiltres = [NSKeyedUnarchiver unarchiveObjectWithFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/TvProgs.Filtres"]];
    
    detailVC = [[DetailView alloc] init];
    detailVC = [[[self splitViewController] viewControllers] objectAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allFiltres count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myFilter *cell = (myFilter *)[tableView dequeueReusableCellWithIdentifier:@"myFilter"];
    if (cell == nil) { cell = [[[NSBundle mainBundle] loadNibNamed:@"myFilter" owner:self options:nil] objectAtIndex:0]; }
    
    
    [cell.nom setText:(NSString *)[allFiltres[indexPath.row] NomFiltre]];
    [cell.compteur setText:[NSString stringWithFormat:@"%d", [detailVC appliquerFiltre:[NSPredicate predicateWithFormat:[allFiltres[indexPath.row] Predicat]] pourDeVrai:NO] ]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [detailVC appliquerFiltre:[NSPredicate predicateWithFormat:[allFiltres[indexPath.row] Predicat] ] pourDeVrai:YES];
}

@end
