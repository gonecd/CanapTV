//
//  Chaine.h
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chaine : NSObject {
    
    NSString *nom;
    NSString *logo;
//    BOOL active;
    NSString *icone;
    NSString *idchaine;

}

@property (nonatomic, retain) NSString *nom;
@property (nonatomic, retain) NSString *logo;
//@property (nonatomic) BOOL active;
@property (nonatomic, retain) NSString *icone;
@property (nonatomic, retain) NSString *idchaine;

@end
