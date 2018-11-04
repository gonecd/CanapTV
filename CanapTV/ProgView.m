//
//  ProgView.m
//  CanapTV
//
//  Created by Cyril Delamare on 05/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "ProgView.h"
#import "DetailView.h"

@interface ProgView ()

@end

@implementation ProgView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    UISwipeGestureRecognizer * swipedRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwiped)];
    swipedRight.numberOfTouchesRequired =1;
    swipedRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipedRight];
    
    [self.etoile5 setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]]];
    [self.etoile4 setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]]];
    [self.etoile3 setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]]];
    [self.etoile2 setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]]];
    [self.etoile1 setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/etoile.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) afficheProgramme:(Prog *)programme {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    texteChaine = [programme chaine];
    texteCSA = [programme Rating];
    
    // Affichage du titre, sous titre, description et showview
    [self.titre setText:(NSString *)[programme Titre] ];
    if ([programme SousTitre] != nil) { [self.soustitre setText:(NSString *)[programme SousTitre] ]; } else { [self.soustitre setText:(NSString *)@""]; }
    if ([programme Resume] != nil) { [self.resume setText:(NSString *)[programme Resume] ]; } else { [self.resume setText:(NSString *)@""]; }
    if ([programme Categorie] != nil) { [self.categorie setText:(NSString *)[programme Categorie] ]; } else { [self.categorie setText:(NSString *)@""]; }
    if ([programme SousCategorie] != nil) { [self.souscategorie setText:(NSString *)[programme SousCategorie] ]; } else { [self.souscategorie setText:(NSString *)@""]; }
    if ([programme critique] != nil) { [self.critique setText:(NSString *)[programme critique] ]; } else { [self.critique setText:(NSString *)@""]; }
    if ([programme Annee] != 0) { [self.annee setText:[NSString stringWithFormat:@"%d", [programme Annee]] ]; } else { [self.annee setText:(NSString *)@""]; }
    
    
    // Affichage du casting
    NSMutableArray * casting = [programme cast];
    NSString * credits = @"";
    for(int i = 0; i < [casting count]; i++) {
        credits = [credits stringByAppendingString:[(Casting *)casting[i] role]];
        credits = [credits stringByAppendingString:@" : "];
        credits = [credits stringByAppendingString:[(Casting *)casting[i] nom]];
        credits = [credits stringByAppendingString:@"\n"];
    }
    if (credits != nil) {[self.casting setText:(NSString *)credits];} else { [self.casting setText:(NSString *)@""]; }
    
    // Affichage des horaires
    [formatter setDateFormat:@"EEEE, dd MMM"];
    [self.jour setText:(NSString *)[formatter stringFromDate:[programme debut]]];
    [formatter setDateFormat:@"HH:mm"];
    [self.debut setText:(NSString *)[formatter stringFromDate:[programme debut]]];
    [formatter setDateFormat:@"HH:mm"];
    [self.fin setText:(NSString *)[formatter stringFromDate:[programme fin]]];

    // Affichage des logos
    if ([[programme Rating] isEqualToString:@"-10"]) { [self.CSA setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/CSA10.png"]]]; }
    else if ([[programme Rating] isEqualToString:@"-12"]) { [self.CSA setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/CSA12.png"]]]; }
    else if ([[programme Rating] isEqualToString:@"-16"]) { [self.CSA setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/CSA16.png"]]]; }
    else if ([[programme Rating] isEqualToString:@"-18"]) { [self.CSA setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/CSA18.png"]]]; }
    else if ([[programme Rating] isEqualToString:@"Tout public"]) { [self.CSA setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/CSAPP.png"]]]; }
    if ([[programme Qualite] isEqualToString:@"HDTV"]) { [self.qualite setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/Qual HD1080.png"]]]; }
    else { [self.qualite setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/Qual LQ.png"]]]; }
    if ([[programme Aspect] isEqualToString:@"16:9"]) { [self.aspect setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/16-9.jpg"]]]; }
    if ([[programme Aspect] isEqualToString:@"4:3"]) { [self.aspect setImage:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/4-3.jpg"]]]; }    
    
    // Affichage des étoiles
    [self.etoile5 setHidden:NO]; [self.etoile4 setHidden:NO]; [self.etoile3 setHidden:NO]; [self.etoile2 setHidden:NO]; [self.etoile1 setHidden:NO];
    if ([[programme Note] isEqualToString:@"4/5"]) { [self.etoile5 setHidden:YES]; }
    if ([[programme Note] isEqualToString:@"3/5"]) { [self.etoile5 setHidden:YES]; [self.etoile4 setHidden:YES]; }
    if ([[programme Note] isEqualToString:@"2/5"]) { [self.etoile5 setHidden:YES]; [self.etoile4 setHidden:YES]; [self.etoile3 setHidden:YES]; }
    if ([[programme Note] isEqualToString:@"1/5"]) { [self.etoile5 setHidden:YES]; [self.etoile4 setHidden:YES]; [self.etoile3 setHidden:YES]; [self.etoile2 setHidden:YES]; }
    if ([[programme Note] isEqualToString:@"?"]) { [self.etoile5 setHidden:YES]; [self.etoile4 setHidden:YES]; [self.etoile3 setHidden:YES]; [self.etoile2 setHidden:YES]; [self.etoile1 setHidden:YES]; }

    
    // Affichage de l'icone de la chaine
    NSString *path = [[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/logos/"] stringByAppendingString:[programme logo]];
    [self.chaine setImage:[[UIImage alloc] initWithContentsOfFile:path]];
  
    // Affichage de l'image du programme
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[programme icone]]]];
    if (image == nil) { image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Default-Landscape~ipad.png"]]; }
    [self.illustration setImage:image];
    
    [self.view setHidden:NO];
    [self.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(321, 0, 704, 768)];
    [UIView commitAnimations];
    

}

-(void) screenSwiped {
    
    [self.view setFrame:CGRectMake(321, 0, 704, 768)];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [UIView commitAnimations];
    
}

- (IBAction)back:(id)sender {
    [self screenSwiped];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Action de filtrage rapide
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)filtreTitre:(id)sender {
    
    DetailView * mydetailVC = [[DetailView alloc] init];
    mydetailVC = [[[[self parentViewController] splitViewController] viewControllers] objectAtIndex:1];
    [mydetailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(Titre == %@)", [self.titre text]] pourDeVrai:YES];
    
    [self screenSwiped];
}

- (IBAction)filtreCategorie:(id)sender {
    
    DetailView * mydetailVC = [[DetailView alloc] init];
    mydetailVC = [[[[self parentViewController] splitViewController] viewControllers] objectAtIndex:1];
    [mydetailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(Categorie == %@)", [self.categorie text]] pourDeVrai:YES];
    
    [self screenSwiped];
}

- (IBAction)filtreSousCategorie:(id)sender {
    
    DetailView * mydetailVC = [[DetailView alloc] init];
    mydetailVC = [[[[self parentViewController] splitViewController] viewControllers] objectAtIndex:1];
    [mydetailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(SousCategorie == %@)", [self.souscategorie text]] pourDeVrai:YES];
    
    [self screenSwiped];
}

- (IBAction)filtreChaine:(id)sender {
    
    DetailView * mydetailVC = [[DetailView alloc] init];
    mydetailVC = [[[[self parentViewController] splitViewController] viewControllers] objectAtIndex:1];
    [mydetailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(chaine == %@)", texteChaine] pourDeVrai:YES];
    
    [self screenSwiped];
}

- (IBAction)filtreCSA:(id)sender {
    
    DetailView * mydetailVC = [[DetailView alloc] init];
    mydetailVC = [[[[self parentViewController] splitViewController] viewControllers] objectAtIndex:1];
    [mydetailVC appliquerFiltre:[NSPredicate predicateWithFormat:@"(Rating == %@)", texteCSA] pourDeVrai:YES];
    
    [self screenSwiped];
}



@end
