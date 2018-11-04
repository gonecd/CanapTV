//
//  ChainesChooser.m
//  CanapTV
//
//  Created by Cyril Delamare on 28/12/2013.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "ChainesChooser.h"
#import "myChaine.h"
#import "Chaine.h"

@interface ChainesChooser ()

@end

@implementation ChainesChooser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    allChaines = [[NSMutableArray alloc] init];
    currentChaines = [[NSArray alloc] init];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *targetChaines = [path stringByAppendingPathComponent:@"complet.chaines"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:targetChaines]) { allChaines = [NSKeyedUnarchiver unarchiveObjectWithFile:targetChaines]; }
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"myChaine" bundle:nil] forCellWithReuseIdentifier:@"myChaine"];
    
    // Configure layout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(100, 100)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 10.0f;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.bounces = YES;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];

    // Gesture de fermeture
    UISwipeGestureRecognizer * swipedRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwiped)];
    swipedRight.numberOfTouchesRequired =1;
    swipedRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipedRight];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)affiche {
    [self.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(321, 0, 704, 768)];
    [UIView commitAnimations];
}

- (void) screenSwiped {
    [self.view setFrame:CGRectMake(321, 0, 704, 768)];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(1024, 0, 704, 768)];
    [UIView commitAnimations];
}

- (void) setChaines:(NSArray *)chaines {
    currentChaines = chaines;
    //allChaines = chaines;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Gestion de la matrice
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [allChaines count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    myChaine *cell = (myChaine *)[cv dequeueReusableCellWithReuseIdentifier:@"myChaine" forIndexPath:indexPath];
    
    NSString *path = [[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/logos/"] stringByAppendingString:[[allChaines objectAtIndex:indexPath.row] logo]];
    cell.logo.image = [[UIImage alloc] initWithContentsOfFile:path];
    cell.nomChaine.text = [[allChaines objectAtIndex:indexPath.row] nom];
    BOOL actived = NO;
    for (int i = 0; i < [currentChaines count]; i++) {
        if ([[[currentChaines objectAtIndex:i] nom] isEqualToString:cell.nomChaine.text]) { actived = YES; }
    }
    if (actived) { cell.backgroundColor = [UIColor greenColor];} else { cell.backgroundColor = [UIColor darkGrayColor];}
    

    return cell;
}


@end
