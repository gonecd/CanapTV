//
//  myCell.m
//  CanapTV
//
//  Created by Cyril Delamare on 02/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "myCell.h"

@implementation myCell

@synthesize Titre = _Titre;
@synthesize SousTitre = _SousTitre;
@synthesize Jour = _Jour;
@synthesize Debut = _Debut;
@synthesize Fin = _Fin;
@synthesize SousCategorie = _SousCategorie;
@synthesize Logo = _Logo;
@synthesize etoile1 = _etoile1;
@synthesize etoile2 = _etoile2;
@synthesize etoile3 = _etoile3;
@synthesize etoile4 = _etoile4;
@synthesize etoile5 = _etoile5;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

