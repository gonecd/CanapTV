//
//  MasterView.m
//  CanapTV
//
//  Created by Cyril Delamare on 01/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "MasterView.h"

@interface MasterView ()

@end

@implementation MasterView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    detailVC = [[DetailView alloc] init];
    
    categs = [[NSArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Gestion du Picker de categories
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) setCategories:(NSArray *)categories {
    categs = [categories sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [categs count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [categs objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self filtrer:pickerView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Actions de filtrage
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)filtrer:(id)sender {
    
    NSString * texteDuPredicat = @"";
    int cont = 0;
    int lcont = 0;
    
    if ((![[self.motCle text] isEqualToString:@""]) && ([self.titre isOn]+[self.sousTitre isOn]+[self.resume isOn] != 0) ){
        texteDuPredicat = @"( ";
        
        if ( [self.titre isOn] == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"Titre CONTAINS[cd] '%@'", [self.motCle text] ]; lcont = 1; }
        if ( [self.sousTitre isOn] == 1) {
            if (lcont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" OR SousTitre CONTAINS[cd] '%@'", [self.motCle text] ]; }
            else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"SousTitre CONTAINS[cd] '%@'", [self.motCle text] ]; lcont = 1; }
        }
        if ( [self.resume isOn] == 1) {
            if (lcont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" OR Resume CONTAINS[cd] '%@'", [self.motCle text] ]; }
            else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"Resume CONTAINS[cd] '%@'", [self.motCle text] ]; }
        }
        
        texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" ) "];
        cont = 1;
    }
    
    if (!([[categs objectAtIndex:[self.categorie selectedRowInComponent:0]] isEqualToString:@"All"])) {
        if (cont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" AND Categorie == '%@'", [categs objectAtIndex:[self.categorie selectedRowInComponent:0]]]; }
        else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"Categorie == '%@'", [categs objectAtIndex:[self.categorie selectedRowInComponent:0]]]; cont = 1; }
    }
        
    NSString * debut;
    NSString * fin;
        
    if ( ([self.jour selectedSegmentIndex] == 0) && ([self.heure selectedSegmentIndex] == 0) ) { debut = @"CAST(now(), 'NSNumber')"; fin = @"CAST(now(), 'NSNumber') + 1800000"; }
    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 1) ) { debut = @"CAST(now(), 'NSNumber')"; fin = @"CAST(now(), 'NSNumber')"; }
    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 2) ) { debut = @"CAST(now(), 'NSNumber') + 1"; fin = @"CAST(now(), 'NSNumber') + 1800"; }
    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 0) ) { debut = @"'today at 00:00'"; fin = @"'today at 23:59'"; }
    if ( ([self.jour selectedSegmentIndex] == 2) && ([self.heure selectedSegmentIndex] == 0) ) { debut = @"'tomorrow at 00:00'"; fin = @"'tomorrow at 23:59'"; }
    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 3) ) { debut = @"'today at 20:30'"; fin = @"'today at 21:01'"; }
    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 4) ) { debut = @"'today at 22:15'"; fin = @"'today at 23:00'"; }
    if ( ([self.jour selectedSegmentIndex] == 2) && ([self.heure selectedSegmentIndex] == 3) ) { debut = @"'tomorrow at 20:30'"; fin = @"'tomorrow at 21:01'"; }
    if ( ([self.jour selectedSegmentIndex] == 2) && ([self.heure selectedSegmentIndex] == 4) ) { debut = @"'tomorrow at 22:15'"; fin = @"'tomorrow at 23:00'"; }

    if ( ([self.jour selectedSegmentIndex] == 1) && ([self.heure selectedSegmentIndex] == 1) ) {
        if (cont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" AND (debut <= CAST(%@,'NSDate') AND fin >= CAST(%@,'NSDate') )", debut, fin ]; }
        else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"(debut <= CAST(%@,'NSDate') AND fin >= CAST(%@,'NSDate') )", debut, fin]; cont = 1; }
    }
    else {
        if (cont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" AND (debut >= CAST(%@,'NSDate') AND debut <= CAST(%@,'NSDate') )", debut, fin ]; }
        else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"(debut >= CAST(%@,'NSDate') AND debut <= CAST(%@,'NSDate') )", debut, fin]; cont = 1; }
    }
    
    if ( [self.source selectedSegmentIndex] == 1) {
        if (cont == 1) { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@" AND (chaine == 'TF1' OR chaine == 'France 2' OR chaine == 'France 3' OR chaine == 'Canal+' OR chaine == 'France 5' OR chaine == 'M6' OR chaine == 'Arte' OR chaine == 'D8' OR chaine == 'W9' OR chaine == 'TMC' OR chaine == 'NT1' OR chaine == 'NRJ 12' OR chaine == 'France 4' OR chaine == 'La Chaîne Parlementaire' OR chaine == 'BFM TV' OR chaine == 'iTélé' OR chaine == 'D17' OR chaine == 'Gulli' OR chaine == 'HD1' OR chaine == '6ter' OR chaine == 'Numéro 23' OR chaine == 'RMC Découverte' OR chaine == 'Chérie 25') " ]; }
        else { texteDuPredicat = [texteDuPredicat stringByAppendingFormat:@"(chaine == 'TF1' OR chaine == 'France 2' OR chaine == 'France 3' OR chaine == 'Canal+' OR chaine == 'France 5' OR chaine == 'M6' OR chaine == 'Arte' OR chaine == 'D8' OR chaine == 'W9' OR chaine == 'TMC' OR chaine == 'NT1' OR chaine == 'NRJ 12' OR chaine == 'France 4' OR chaine == 'La Chaîne Parlementaire' OR chaine == 'BFM TV' OR chaine == 'iTélé' OR chaine == 'D17' OR chaine == 'Gulli' OR chaine == 'HD1' OR chaine == '6ter' OR chaine == 'Numéro 23' OR chaine == 'RMC Découverte' OR chaine == 'Chérie 25')" ]; }        
    }
   
    detailVC = [[[self splitViewController] viewControllers] objectAtIndex:1];
    [detailVC appliquerFiltre:[NSPredicate predicateWithFormat:texteDuPredicat] pourDeVrai:YES];
}

- (IBAction)selectQuand:(id)sender {
    
    if (sender == self.jour) {
        if ( [self.jour selectedSegmentIndex] == 0) { [self.heure setSelectedSegmentIndex:0]; }
        //if ( [self.jour selectedSegmentIndex] == 1) { return; }
        if ( [self.jour selectedSegmentIndex] == 2) { if ( ([self.heure selectedSegmentIndex] == 1) || ([self.heure selectedSegmentIndex] == 2) ) { [self.heure setSelectedSegmentIndex:0]; } }
    }

    if (sender == self.heure) {
        //if ( [self.heure selectedSegmentIndex] == 0) { return; }
        if ( [self.heure selectedSegmentIndex] == 1) { [self.jour setSelectedSegmentIndex:1]; }
        if ( [self.heure selectedSegmentIndex] == 2) { [self.jour setSelectedSegmentIndex:1]; }
        if ( [self.heure selectedSegmentIndex] == 3) { if ( [self.jour selectedSegmentIndex] == 0) { [self.jour setSelectedSegmentIndex:1]; } }
        if ( [self.heure selectedSegmentIndex] == 4) { if ( [self.jour selectedSegmentIndex] == 0) { [self.jour setSelectedSegmentIndex:1]; } }
    }

    [self filtrer:sender];

}

- (IBAction)refresh:(id)sender {
    
    [self filtrer:sender];
}



@end
