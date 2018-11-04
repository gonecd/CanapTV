//
//  ChainesChooser.h
//  CanapTV
//
//  Created by Cyril Delamare on 28/12/2013.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ChainesChooser : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
//@interface ChainesChooser : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
@interface ChainesChooser : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {

    NSMutableArray *allChaines;
    NSArray *currentChaines;

}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;

-(void) affiche;
-(void) screenSwiped;

-(void) setChaines:(NSArray *)chaines;

@end
