//
//  Chaine.m
//  CanapTV
//
//  Created by Cyril Delamare on 08/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "Chaine.h"

@implementation Chaine


@synthesize nom;
@synthesize logo;
//@synthesize active;
@synthesize icone;
@synthesize idchaine;


-(void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:nom forKey:@"nom"];
    [coder encodeObject:logo forKey:@"logo"];
//    [coder encodeObject:active forKey:@"active"];
    [coder encodeObject:icone forKey:@"icone"];
    [coder encodeObject:idchaine forKey:@"idchaine"];
}

-(id) initWithCoder:(NSCoder *) coder {
    if (self = [super init]) {
        nom = [coder decodeObjectForKey:@"nom"];
        logo = [coder decodeObjectForKey:@"logo"];
//        active = [coder decodeObjectForKey:@"active"];
        icone = [coder decodeObjectForKey:@"icone"];
        idchaine = [coder decodeObjectForKey:@"idchaine"];
    }
    return self;
}


@end
