//
//  myCell.h
//  CanapTV
//
//  Created by Cyril Delamare on 02/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel * Titre;
@property (strong, nonatomic) IBOutlet UILabel * SousTitre;
@property (strong, nonatomic) IBOutlet UILabel * Jour;
@property (strong, nonatomic) IBOutlet UILabel * Debut;
@property (strong, nonatomic) IBOutlet UILabel * Fin;
@property (strong, nonatomic) IBOutlet UILabel * SousCategorie;
@property (strong, nonatomic) IBOutlet UIImageView * Logo;
@property (weak, nonatomic) IBOutlet UIImageView *etoile1;
@property (weak, nonatomic) IBOutlet UIImageView *etoile2;
@property (weak, nonatomic) IBOutlet UIImageView *etoile3;
@property (weak, nonatomic) IBOutlet UIImageView *etoile4;
@property (weak, nonatomic) IBOutlet UIImageView *etoile5;


@end
