//
//  FirstViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/17/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebData.h"
#import "SDWebImageManager.h"

@interface FirstViewController : UIViewController<WebDataDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SDWebImageManagerDelegate>
{
    WebData *webResponse;
    IBOutlet UIImageView *bgImage;
    
    
}
@property (strong, nonatomic) NSMutableArray *iconsArray;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property(nonatomic) BOOL showLaunchScreen;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
