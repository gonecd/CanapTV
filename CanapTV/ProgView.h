//
//  ProgView.h
//  CanapTV
//
//  Created by Cyril Delamare on 05/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prog.h"


@interface ProgView : UIViewController <UIGestureRecognizerDelegate> {
    
    NSString * texteChaine;
    NSString * texteCSA;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titre;
@property (weak, nonatomic) IBOutlet UILabel *soustitre;
@property (weak, nonatomic) IBOutlet UIImageView *illustration;
@property (weak, nonatomic) IBOutlet UIImageView *chaine;
@property (weak, nonatomic) IBOutlet UILabel *categorie;
@property (weak, nonatomic) IBOutlet UILabel *souscategorie;
@property (weak, nonatomic) IBOutlet UILabel *jour;
@property (weak, nonatomic) IBOutlet UILabel *debut;
@property (weak, nonatomic) IBOutlet UILabel *fin;
@property (weak, nonatomic) IBOutlet UITextView *resume;
@property (weak, nonatomic) IBOutlet UITextView *casting;
@property (weak, nonatomic) IBOutlet UIImageView *aspect;
@property (weak, nonatomic) IBOutlet UIImageView *CSA;
@property (weak, nonatomic) IBOutlet UIImageView *qualite;
@property (weak, nonatomic) IBOutlet UILabel *annee;
@property (weak, nonatomic) IBOutlet UITextView *critique;
@property (weak, nonatomic) IBOutlet UIImageView *etoile1;
@property (weak, nonatomic) IBOutlet UIImageView *etoile2;
@property (weak, nonatomic) IBOutlet UIImageView *etoile3;
@property (weak, nonatomic) IBOutlet UIImageView *etoile4;
@property (weak, nonatomic) IBOutlet UIImageView *etoile5;


-(void) afficheProgramme:(Prog *)programme;
-(void) screenSwiped;

- (IBAction)back:(id)sender;

- (IBAction)filtreTitre:(id)sender;
- (IBAction)filtreSousCategorie:(id)sender;
- (IBAction)filtreCategorie:(id)sender;
- (IBAction)filtreCSA:(id)sender;
- (IBAction)filtreChaine:(id)sender;


@end
