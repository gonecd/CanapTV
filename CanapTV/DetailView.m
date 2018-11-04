//
//  DetailView.m
//  CanapTV
//
//  Created by Cyril Delamare on 01/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "DetailView.h"
#import "myCell.h"
#import "Prog.h"
#import "Chaine.h"
#import "MasterView.h"
#import "ChainesView.h"
#import "ProgView.h"
#import "Aview.h"
#import "ChainesChooser.h"

@interface DetailView ()

@end



@implementation DetailView

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Instanciation de la fenêtre de visualisation des programmes
    progVC = [[ProgView alloc] init];
    [progVC.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [[[self splitViewController] view] addSubview:[progVC view]];
    
    // Instanciation de la fenêtre de choix des chaines
    chainesChooser = [[ChainesChooser alloc] init];
    [chainesChooser.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [[[self splitViewController] view] addSubview:[chainesChooser view]];
    
    // Initialisation des variables
	allProgs = [[NSMutableArray alloc] init];
	progs = [[NSArray alloc] init];
    allProgs = [NSKeyedUnarchiver unarchiveObjectWithFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Complet.Progs"]];
    allProgs = [NSMutableArray arrayWithArray:[allProgs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"fin >= CAST(CAST(now(), 'NSNumber'),'NSDate')"]]];
    progs = [NSArray arrayWithArray:allProgs];
    
    // Initialisation de la liste des categories
    MasterView * masterVC = [[MasterView alloc] init];
    UITabBarController * tabVC = [[UITabBarController alloc] init];
    tabVC = [[[self splitViewController] viewControllers] objectAtIndex:0];
    masterVC = [[tabVC viewControllers] objectAtIndex:0];
    [masterVC setCategories:[self getCategories]];

    // Initialisation de la liste des chaines
    ChainesView * chainesVC = [[ChainesView alloc] init];
    chainesVC = [[tabVC viewControllers] objectAtIndex:2];
    [chainesVC setChaines:[self getChaines]];
    [chainesChooser setChaines:[self getChaines]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Gestion de la liste
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [progs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    myCell *cell = (myCell *)[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"myCell" owner:self options:nil] objectAtIndex:0];
        
        UIImage * etoile = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]];
        [cell.etoile1 setImage:etoile];
        [cell.etoile2 setImage:etoile];
        [cell.etoile3 setImage:etoile];
        [cell.etoile4 setImage:etoile];
        [cell.etoile5 setImage:etoile];
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [cell.Titre setText:(NSString *)[progs[indexPath.row] Titre]];
    [cell.SousTitre setText:(NSString *)[progs[indexPath.row] SousTitre]];
    [cell.SousCategorie setText:(NSString *)[progs[indexPath.row] SousCategorie]];
    
    [formatter setDateFormat:@"EEEE, dd MMM"];
    [cell.Jour setText:[formatter stringFromDate:[progs[indexPath.row] debut]]];

    [formatter setDateFormat:@"HH:mm"];
    [cell.Debut setText:[formatter stringFromDate:[progs[indexPath.row] debut]]];
    [cell.Fin setText:[formatter stringFromDate:[progs[indexPath.row] fin]]];
    
    NSString *path = [[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/logos/"] stringByAppendingString:[progs[indexPath.row] logo]];
    [cell.Logo setImage:[[UIImage alloc] initWithContentsOfFile:path] ];

    [cell.etoile5 setHidden:NO]; [cell.etoile4 setHidden:NO]; [cell.etoile3 setHidden:NO]; [cell.etoile2 setHidden:NO]; [cell.etoile1 setHidden:NO];
    if ([[progs[indexPath.row] Note] isEqualToString:@"4/5"]) { [cell.etoile5 setHidden:YES]; }
    if ([[progs[indexPath.row] Note] isEqualToString:@"3/5"]) { [cell.etoile5 setHidden:YES]; [cell.etoile4 setHidden:YES]; }
    if ([[progs[indexPath.row] Note] isEqualToString:@"2/5"]) { [cell.etoile5 setHidden:YES]; [cell.etoile1 setHidden:YES]; [cell.etoile4 setHidden:YES]; }
    if ([[progs[indexPath.row] Note] isEqualToString:@"1/5"]) { [cell.etoile5 setHidden:YES]; [cell.etoile4 setHidden:YES]; [cell.etoile3 setHidden:YES]; [cell.etoile2 setHidden:YES]; }
    if ([[progs[indexPath.row] Note] isEqualToString:@"?"]) { [cell.etoile5 setHidden:YES]; [cell.etoile4 setHidden:YES]; [cell.etoile3 setHidden:YES]; [cell.etoile2 setHidden:YES]; [cell.etoile1 setHidden:YES]; }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [progVC afficheProgramme:[progs objectAtIndex:[indexPath row]]];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Gestion des autres fenêtres
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)afficheChaines{
    [chainesChooser affiche];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Action de filtrage
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger) appliquerFiltre:(NSPredicate *)predicat pourDeVrai:(BOOL)vraiment {
    
    if (vraiment) {
        progs = [allProgs filteredArrayUsingPredicate:predicat];
        [self.table reloadData];
        
        return [progs count];
        
    }
    else {
        return [[allProgs filteredArrayUsingPredicate:predicat] count];
    }

}

- (IBAction)triDate:(id)sender {
    progs = [progs sortedArrayUsingDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"debut" ascending:YES], nil]];
    [self.table reloadData];
}

- (IBAction)triChaine:(id)sender {
    progs = [progs sortedArrayUsingDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"chaine" ascending:YES], nil]];
    [self.table reloadData];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Méthodes d'accès pour les autres Views
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray *) getCategories {
   
    NSMutableArray * tab = [[NSMutableArray alloc] init];
    [tab addObject:@"All"];
    
    for(int i = 0; i < [allProgs count]; i++) {	[tab addObject:[allProgs[i] Categorie]]; }
    NSSet *mySet = [NSSet setWithArray:tab];
    
    [tab removeAllObjects];
    
    [tab addObjectsFromArray:[mySet allObjects]];
    
    return [mySet allObjects];
}

- (NSArray *) getChaines {
    
    NSMutableSet *setNom = [[NSMutableSet alloc] init];
    
    NSMutableArray * tab = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [allProgs count]; i++) {
        [setNom addObject:[NSString stringWithFormat:@"%@;%@", [allProgs[i] chaine], [allProgs[i] logo] ]];
    }
    
    NSString * str;
    for(str in [[setNom objectEnumerator] allObjects]) {
        Chaine *uneChaine = [[Chaine alloc] init];
        uneChaine.nom = [[str componentsSeparatedByString:@";"] objectAtIndex:0];
        uneChaine.logo = [[str componentsSeparatedByString:@";"] objectAtIndex:1];
//        uneChaine.active = YES;
        [tab addObject:uneChaine];
    }
   
    return [tab sortedArrayUsingDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"nom" ascending:YES], nil]];
}

- (NSDate *) debut {
    return [[allProgs objectAtIndex:0] debut];    
}

- (NSDate *) fin {
    return [[allProgs objectAtIndex:[allProgs count]-1] fin];
}

- (NSInteger) nombre {
    return [allProgs count];
}



@end
