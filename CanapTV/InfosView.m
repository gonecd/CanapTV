//
//  InfosView.m
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "InfosView.h"
#import "SSZipArchive.h"
#import "XMLToObjectParser.h"
#import "Prog.h"
#import "Chaine.h"

@interface InfosView ()

@end

@implementation InfosView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    detailVC = [[DetailView alloc] init];
    detailVC = [[[self splitViewController] viewControllers] objectAtIndex:1];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd MMM HH:mm"];
    
    [self.debut setText:[formatter stringFromDate:[detailVC debut]]];
    [self.fin setText:[formatter stringFromDate:[detailVC fin]]];
    [self.nombre setText:[NSString stringWithFormat:@"%ld", (long)[detailVC nombre]]];
    [self.nbchaines setText:[NSString stringWithFormat:@"%ld", (unsigned long)[[detailVC getChaines] count]]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recharger:(id)sender {

    // Sources alternatives :
    // http://kevinpato.free.fr/xmltv/download/complet.zip
    // http://kevinpato.free.fr/xmltv/download/tnt.zip
    // http://xmltv.dyndns.org/download/complet.zip
    // http://xmltv.dyndns.org/download/tnt.zip
    
    NSData *urlData;
    NSMutableArray *locProgs = [[NSMutableArray alloc] init];
    NSMutableArray *locChaines = [[NSMutableArray alloc] init];
    NSMutableArray *locChaines2 = [[NSMutableArray alloc] init];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *source = @"http://xmltv.dyndns.org/download/complet.zip";
    NSString *zipfile = [path stringByAppendingPathComponent:@"complet.zip"];
    NSString *fichier = [path stringByAppendingPathComponent:@"complet.xml"];
    NSString *targetProgs = [path stringByAppendingPathComponent:@"complet.prog"];
    NSString *targetChaines = [path stringByAppendingPathComponent:@"complet.chaines"];
    
    // Download du fichier zip
    NSLog(@"Loading ...");
    urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:source]];
    if ( urlData ) { [urlData writeToFile:zipfile atomically:YES]; }
    
    // Unzip
    NSLog(@"Unzipping ...");
    [SSZipArchive unzipFileAtPath:zipfile toDestination:path];
    
    // Parsing du fichier
    NSLog(@"Parsing ...");
    XMLToObjectParser * myParser = [[XMLToObjectParser alloc] parseXMLfromFile:[NSInputStream inputStreamWithFileAtPath:fichier] parseError:nil];

    // Création de la structure interne
    NSLog(@"Building ...");
    
    // Initialisation du tableau de chaines
    for(int i = 0; i < 5000; i++) { Chaine *new = [[Chaine alloc] init]; [locChaines addObject:new]; }
    for(int i = 0; i < [[myParser chaines] count]; i++){
        locChaines[[[[(Chaine *)[myParser chaines][i] idchaine] substringFromIndex:1] intValue]] = (Chaine *)[myParser chaines][i];
    }
    
    for(int i = 0; i < [[myParser chaines] count]; i++){
        Chaine *new = [[Chaine alloc] init];
        new = (Chaine *)[myParser chaines][i];
        new.logo = [new.icone stringByReplacingOccurrencesOfString:@"http://localhost/" withString:@""];
        [locChaines2 addObject:new];
    }
    
    for(int i = 0; i < [[myParser programmes] count]; i++) {
        Prog *new = [[Prog alloc] init];
        new = (Prog *)[myParser programmes][i];
        
        new.logo = [[locChaines[[[new.chaine substringFromIndex:1] intValue]] icone] stringByReplacingOccurrencesOfString:@"http://localhost/" withString:@""];
        new.chaine = [locChaines[[[new.chaine substringFromIndex:1] intValue]] nom];
        
        if ( [new.Resume rangeOfString:@"--  Critique : "].location != NSNotFound ) {
            NSArray * tab = [new.Resume componentsSeparatedByString:@"--  Critique : "];
            new.Resume = [tab objectAtIndex:0];
            new.critique = [tab objectAtIndex:1];
        }
        else { new.critique = @""; }
        
        if ( !([new.Categorie isEqualToString:@"météo"]) && !([new.Categorie isEqualToString:@"fin"]) && !([new.SousCategorie isEqualToString:@"programme indéterminé"])) { [locProgs addObject:new]; }
    }

    // Sauvegarde du fichier
    NSLog(@"Saving ...");
    [NSKeyedArchiver archiveRootObject:[locProgs sortedArrayUsingDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"debut" ascending:YES], nil]] toFile:targetProgs];
    [NSKeyedArchiver archiveRootObject:[locChaines2 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"nom" ascending:YES], nil]] toFile:targetChaines];
    //[NSKeyedArchiver archiveRootObject:locChaines2 toFile:targetChaines];

    NSLog(@"Finishing ...");

}
@end
